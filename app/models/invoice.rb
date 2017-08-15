class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transaction
  
  belongs_to :customer
  belongs_to :merchant
end
