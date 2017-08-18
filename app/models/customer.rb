class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  validates :first_name, :last_name, presence: true

  def favorite_merchant
    invoices
      .select('merchants.*, count(invoices.id) AS customer_transactions')
      .joins(:transactions, :merchant)
      .merge(Transaction.successful)
      .group('merchants.id')
      .order('customer_transactions DESC')
      .first
  end
end
