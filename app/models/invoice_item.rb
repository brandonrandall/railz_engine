class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  before_save :set_unit_price

  def set_unit_price
    self.unit_price = self.unit_price/100
  end
end
