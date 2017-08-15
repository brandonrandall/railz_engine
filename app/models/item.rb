class Item < ApplicationRecord
    # validates :id,:name,:description,:unit_price, presence: true
    has_many :invoice_items
    has_many :invoices, through: :invoice_items
end
