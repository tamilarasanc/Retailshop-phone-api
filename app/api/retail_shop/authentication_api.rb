
require 'jwt_helper'
module RetailShop
  class AuthenticationAPI < Grape::API # :nodoc:
    prefix 'api'
    version 'v1', using: :path
    format :json

    resources :users do
      desc 'Authenticate'
      params do
        requires :email, type: String, desc: 'Email'
        requires :password, type: String, desc: 'Password'
      end
      post :authenticate do
        declared_params = declared(params, include_missing: false)
        password = Digest::MD5.hexdigest(declared_params[:password])
        user = User.find_by(email_id: declared_params[:email], password: password)
        if user
          if user.active?
            jwt_token = JWTHelper.encode(user_id: user.id, role_id: user.role_id)
            user = {token: jwt_token,
                    role: user.role_id,
                    user: {
                        id: user.id,
                        name: user.name,
                        email_id: user.email_id,
                        role: user.role_name
                    },
            }
            { status: 200, user: user }
          else
            error!("#{user.name} is currently Inactive", 401)
          end
        else
          error!("Invalid user/password", 401)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
