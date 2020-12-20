
module RetailShop
  class PurchasesAPI < Grape::API
    helpers do

    end

    namespace :shops do
      route_param :shop_id do
        after_validation do
          @shop = Shop.find(params[:shop_id])
        end

            desc 'Purchase products'
            params do
              requires :products, type: Array[Integer], allow_blank: false
              requires :shipping_address, type: Hash do
                requires :name, type: String, allow_blank: false
                requires :address1, type: String, allow_blank: false
                optional :address2, type: String, allow_blank: true
                requires :state, type: String, allow_blank: false
                requires :city, type: String, allow_blank: false
                requires :postal_code, type: Integer, allow_blank: false
              end
            end
            post 'purchase' do
              declared_params = declared(params, include_missing: false)
              products = Product.find(declared_params[:products])
              ActiveRecord::Base.transaction do
                  products.each do |product|
                    shipping  = Shipping.create!(declared_params[:shipping_address])
                    product.shipping = shipping
                    product.purchased!
                  end
              end
              status 200
              {products: products,message: "Products purchased successfully"}
            end

        desc 'Get purchased products'
        params do
          optional :limit, type: Integer, default: 30
          optional :offset, type:Integer, default: 0
        end
        get 'purchased' do
          declared_params = declared(params, include_missing: false)
          products = @shop.products.sold.limit(declared_params[:limit]).offset(declared_params[:offset]).includes(:shipping)
          {
              products: products.map{|product| { product: product,
                                           shipping_details: product.shipping,
                                           purchase_date: product.purchase.date.strftime("%Y/%m/%d")}},
              total_records: @shop.products.sold.count
          }
        end

      end
    end
  end
end
