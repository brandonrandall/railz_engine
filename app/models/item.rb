class Item < ApplicationRecord
    # validates :id,:name,:description,:unit_price, presence: true
    has_many :invoice_items
    has_many :invoices, through: :invoice_items

    before_save :set_unit_price

    private

    def set_unit_price
      self.unit_price = self.unit_price/100
    end
end
