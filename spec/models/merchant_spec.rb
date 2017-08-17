require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it {is_expected.to validate_presence_of(:name)}
  end

  describe 'instance methods' do
    describe '#total_revenue' do
      it "returns total revenue for successful transactions" do
        merchant = create(:merchant)
        successful_transactions = create_list(:transaction, 3, result: 'success')
        failed_transactions = create_list(:transaction, 2, result: 'failed')
        invoice = create(:invoice, merchant_id: merchant.id)
        invoice2 = create(:invoice, merchant_id: merchant.id)
        invoice.transactions << successful_transactions
        invoice2.transactions << failed_transactions
        invoice.invoice_items << create_list(:invoice_item, 3, quantity: 3, unit_price: 400)
        invoice2.invoice_items << create_list(:invoice_item, 3, quantity: 3, unit_price: 400)

        result = merchant.total_revenue

        expect(result).to eq(1.08)
      end
    end
  end
end
