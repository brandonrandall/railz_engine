class Merchant < ApplicationRecord
  validates :name, presence: true
  has_many :invoices

  def self.most_items(quantity = nil)
    select('merchants.*, sum(invoice_items.quantity) AS item_count')
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order('item_count DESC')
      .limit(quantity)
  end
end
