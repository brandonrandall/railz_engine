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

    describe '#total_revenue_by_date' do
      it "returns total revenue by date" do
        merchant = create(:merchant)
        successful_transactions = create_list(:transaction, 3, result: 'success')
        failed_transactions = create_list(:transaction, 2, result: 'failed')
        invoice = create(:invoice, merchant_id: merchant.id, created_at: "2012-03-16 11:55:05")
        invoice2 = create(:invoice, merchant_id: merchant.id)
        invoice.transactions << successful_transactions
        invoice2.transactions << failed_transactions
        invoice.invoice_items << create_list(:invoice_item, 3, quantity: 3, unit_price: 400)
        invoice2.invoice_items << create_list(:invoice_item, 3, quantity: 3, unit_price: 400)

        result = merchant.total_revenue_by_date("2012-03-16 11:55:05")

        expect(result).to eq(1.08)
      end
    end
  end

  describe 'class methods' do
    describe '.most_items' do
      it "returns merchants ordered by # of items sold" do
        merchant = create(:merchant)
        successful_transactions = create_list(:transaction, 3, result: 'success')
        invoice = create(:invoice, merchant_id: merchant.id, created_at: "2012-03-16 11:55:05")
        invoice.transactions << successful_transactions
        invoice.invoice_items << create_list(:invoice_item, 3, quantity: 3, unit_price: 400)

        merchant2 = create(:merchant)
        successful_transactions2 = create_list(:transaction, 3, result: 'success')
        invoice2 = create(:invoice, merchant_id: merchant2.id, created_at: "2012-03-16 11:55:05")
        invoice2.transactions << successful_transactions2
        invoice2.invoice_items << create_list(:invoice_item, 6, quantity: 3, unit_price: 400)

        merchant3 = create(:merchant)
        successful_transactions3 = create_list(:transaction, 3, result: 'success')
        invoice3 = create(:invoice, merchant_id: merchant3.id, created_at: "2012-03-16 11:55:05")
        invoice3.transactions << successful_transactions3
        invoice3.invoice_items << create_list(:invoice_item, 4, quantity: 3, unit_price: 400)

        expected = [merchant2, merchant3, merchant]
        result = Merchant.most_items

        expect(result).to eq(expected)
      end

      it "returns the top x merchants by # of items sold" do
        merchant = create(:merchant)
        successful_transactions = create_list(:transaction, 3, result: 'success')
        invoice = create(:invoice, merchant_id: merchant.id, created_at: "2012-03-16 11:55:05")
        invoice.transactions << successful_transactions
        invoice.invoice_items << create_list(:invoice_item, 3, quantity: 3, unit_price: 400)

        merchant2 = create(:merchant)
        successful_transactions2 = create_list(:transaction, 3, result: 'success')
        invoice2 = create(:invoice, merchant_id: merchant2.id, created_at: "2012-03-16 11:55:05")
        invoice2.transactions << successful_transactions2
        invoice2.invoice_items << create_list(:invoice_item, 6, quantity: 3, unit_price: 400)

        merchant3 = create(:merchant)
        successful_transactions3 = create_list(:transaction, 3, result: 'success')
        invoice3 = create(:invoice, merchant_id: merchant3.id, created_at: "2012-03-16 11:55:05")
        invoice3.transactions << successful_transactions3
        invoice3.invoice_items << create_list(:invoice_item, 4, quantity: 3, unit_price: 400)

        expected = [merchant2, merchant3]
        result = Merchant.most_items(2)

        expect(result.to_a.count).to eq(2)
        expect(result).to eq(expected)
      end
    end
  end
end
