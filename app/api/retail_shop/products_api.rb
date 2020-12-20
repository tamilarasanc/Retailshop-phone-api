module RetailShop
  class ProductsAPI < Grape::API
    helpers do

    end

    namespace :shops do
      route_param :shop_id do
        after_validation do
          @shop = Shop.find(params[:shop_id])
        end

        desc 'Products listing based on shop with limit and offset'
        params do
          optional :limit, type: Integer, default: 30
          optional :offset, type: Integer, default: 0
        end
        get 'products' do
          declared_params = declared(params, include_missing: false)
          {
              products: @shop.products.stocks.limit(declared_params[:limit]).offset(declared_params[:offset]),
              total_records: @shop.products.stocks.count
          }
        end

        desc 'Import products into the inventry'
        params do
          requires :file, type: File, allow_blank: false
        end
        post 'bulk_import' do
          declared_params = declared(params, include_missing: false)
          errors = []
          # TODO: This will soon move to background job based on requirement and size of inventory
          data = Roo::Spreadsheet.open(declared_params[:file]['tempfile']) # open spreadsheet
          headers = data.row(1) # get header row
          data.each_with_index do |row, idx|
            next if idx == 0 # skip header
            user_data = Hash[[headers, row].transpose]
            product = @shop.products.build(user_data)
            unless product.save
              errors.push({data: user_data, message: product.errors.messages})
            end
          end
          if errors.length > 0
            error!(errors, 422)
          else
            status 200
            {message: 'Inventory updated with uploaded data'}
          end
        end
      end
    end
  end
end
