module RetailShop
  class API < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api

    rescue_from ActiveRecord::RecordNotFound do |e|
      error!(e, 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error!(e, 422)
    end

    helpers do

      def request_info(env)
        operation = env['REQUEST_METHOD']
        action = API.recognize_path(env['REQUEST_PATH']).options[:path].first
        { operation: operation, action: action }
      end

      def token_authenticate
        return false unless env['HTTP_AUTHORIZATION'].present?
        claim = decode_claims
        return false unless claim
        puts claim
        @user = User.find_by(id: claim['user_id'])
        @role = Role.find_by(id: claim['role_id'])
        if @user && @role
          return validate_permission(env['REQUEST_METHOD'], env['REQUEST_PATH'], claim['role_id'].to_s)
        end
        return true
      end

      def validate_permission(type, url, role_id)
        return true unless Role::PERMISSION[role_id.to_s].length > 0
        return true unless Role::PERMISSION[role_id.to_s].select{|a| a[:type] == type}.length > 0
        Role::PERMISSION[role_id.to_s].select{|a| a[:type] == type}.pluck(:url).each do |url_rejex|
          return true if url.match(url_rejex)
        end
        return false
      end

      def decode_claims
        strategy, token = env['HTTP_AUTHORIZATION'].split(' ')

        return nil unless (strategy || '').casecmp('bearer').zero?

        begin
          JWTHelper.decode(token)
        rescue
          nil
        end
      end

      def authenticate_routes
        Role::PERMISSIONS_REQUIRED.each do |url|
          if url.match(env['REQUEST_PATH'])
            return true
          end
        end
        return false
      end

      def authenticate
        # TODO:Enable this after login provide to end users also
        # unless env['HTTP_AUTHORIZATION'].present?
        #   error! 'Access Denied', 401
        # end
        if authenticate_routes
          unless token_authenticate
            error! 'Access Denied', 401
          end
        end
      end
    end

    before do
      unless request_info(env)[:action] == '/swagger_doc'
        unless env['REQUEST_PATH'].split('/')[-1] == 'authenticate'
          authenticate
        end
      end
    end

    mount RetailShop::AuthenticationAPI
    mount RetailShop::ProductsAPI
    mount RetailShop::PurchasesAPI

    add_swagger_documentation mount_path: '/swagger_doc'

    desc 'Available routes with description and version'
    get :routes do
      Grape::API.decorated_routes.map do |route|
        {
            route_path: route.route_path,
            route_method: route.route_method,
            helper_names: route.helper_names,
            helper_arguments: route.helper_arguments,
            description: route.route.options[:description],
        }
      end
    end
  end
end

