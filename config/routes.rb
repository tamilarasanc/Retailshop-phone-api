Rails.application.routes.draw do
  mount RetailShop::API => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
