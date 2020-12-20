class Purchase < ApplicationRecord
  belongs_to :product
  belongs_to :shipping

  before_save :purchase_date_entry

  def purchase_date_entry
    self.date = Time.now
  end
end
