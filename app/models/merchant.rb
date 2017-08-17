class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :invoices

  def total_revenue
    invoices
      .joins(:transactions, :invoice_items)
      .merge(Transaction.successful)
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def total_revenue_by_date(date)
    invoices
      .joins(:transactions, :invoice_items)
      .merge(Transaction.successful)
      .where(invoices: {created_at: date})
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
