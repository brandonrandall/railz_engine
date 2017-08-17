class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :invoices

  def total_revenue
    invoices
      .joins(:transactions, :invoice_items)
      .merge(Transaction.successful)
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
