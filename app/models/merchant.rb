class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
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

  def favorite_customer
    Customer.joins(:transactions)
            .merge(Transaction.successful)
            .where(invoices: {merchant_id: id})
            .group('customers.id')
            .order("count(customers.id) desc")
            .first
  end

  def self.most_revenue(limit)
    joins(invoices: [:transactions, :invoice_items])
    .merge(Transaction.successful)
    .group("merchants.id").order("SUM(invoice_items.quantity*invoice_items.unit_price) DESC")
    .limit(limit)
  end
end
