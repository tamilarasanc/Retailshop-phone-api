class Product < ApplicationRecord
  validates :manufacturer, format: { with: /\A[A-Za-z ]+\z/, message: "Enter valid manufacturer" }
  validates :model, format: { with: /\A[a-zA-Z0-9 ]*\z/, message: "Enter valid model number" }
  validates :storage, format: { with: /([0-9]+(GB|MB))/, message: "Enter proper storage format" }
  validates :year, format: { with: /\A([1][8-9][0-9][0-9]|[2][0][0-9][0-9])\z/, message: "Enter year between 1800 - 2021" }
  validates :color, format: { with: /\D/, message: "Enter valid color" }
  validates :price, format: { with: /[1-9\.]/, message: "Enter valid price" }
  belongs_to :shop
  has_one :purchase
  has_one :shipping, through: :purchase

  enum status: { purchased: 1, available: 0 }

  scope :stocks, -> {available.order(updated_at: :desc)}
  scope :sold, -> {purchased.order(updated_at: :desc)}
end
