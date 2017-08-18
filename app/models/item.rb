class Item < ApplicationRecord
    validates_presence_of :name, :description
    has_many :invoice_items
    has_many :invoices, -> { distinct }, through: :invoice_items
    belongs_to :merchant

    belongs_to :merchant
    before_save :set_unit_price
  
    def best_day
      invoices
        .select('invoices.*, sum(invoice_items.quantity) AS purchases')
        .joins(:transactions, :invoice_items)
        .merge(Transaction.successful)
        .group(:id)
        .order('purchases DESC, invoices.created_at DESC')
        .first
    end

    def self.most_items(quantity = nil)
      select('items.*, sum(invoice_items.quantity) as num_sold')
        .joins(:invoice_items, invoices: [:transactions])
        .merge(Transaction.successful)
        .group(:id)
        .order('num_sold DESC')
        .limit(quantity)

    private

    def set_unit_price
      self.unit_price = self.unit_price/100
    end
end
