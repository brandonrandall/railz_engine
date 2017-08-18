class Invoice < ApplicationRecord

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  belongs_to :customer
  belongs_to :merchant

end

# FOR TRANSACTION
# scope :successful, ~> { where(result: 'success')}
# == Transaction.successful
# SAME AS
# def self.successful
  # where {result: 'success'}
# end

# scope :paid, ~> {
#   joins(:transactions).merge(Transaction.successful)
# }

# def self.most_expensive(limit = 5)
#   # .select("invoices.*, sum(invoice_items.unit_price*invoice_items.quantity) as total_rev")
#   select("invoices.id, sum(invoice_items.unit_price*invoice_items.quantity) as total_rev")
#   # .joins(:transactions, :invoice_items)
#   .joins(:invoice_items)
#   # .where("transactions.result=?","success")
#   # .where(transactions: {result: "success"})
#
#   # .merge(Transaction.successful)
#
#   # .group("invoices.id")
#   .group(:id)
#   .order("total_rev DESC")
#   .limit(limit)
# end
