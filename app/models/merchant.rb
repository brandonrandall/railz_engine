class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :InvoiceItems
  has_many :invoices
  has_many :items

  # def total_rev
  #   invoices
  #   .joins(:trans, :inv_item)
  #   .merge(Tran.succ)
  #   .sum('inv_itm.unit_price*inv_itm.quan')
  # end
end
