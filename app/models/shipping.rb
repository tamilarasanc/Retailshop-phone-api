class Shipping < ApplicationRecord
  has_one :purchase
  has_one :product, through: :purchase

  validates :name, format: { with: /\A[A-Za-z ]+\z/, message: "Enter valid name" }
  validates :address1, presence: true
  validates :state, format: { with: /\A[A-Za-z ]+\z/, message: "Enter valid state" }
  validates :city, format: { with: /\A[A-Za-z ]+\z/, message: "Enter valid city" }
  validates :postal_code, format: { with: /[0-9\.]/, message: "Enter valid postal code" }
end
