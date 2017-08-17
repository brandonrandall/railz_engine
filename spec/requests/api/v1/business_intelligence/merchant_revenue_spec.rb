require 'rails_helper'

RSpec.describe 'Merchant API Revenue' do
  it "returns the revenue for a single merchant" do
    merchant = create(:merchant)
    successful_transactions = create_list(:transaction, 3, result: 'success')
    failed_transactions = create_list(:transaction, 2, result: 'failed')
    invoice = create(:invoice, merchant_id: merchant.id)
    invoice2 = create(:invoice, merchant_id: merchant.id)
    invoice.transactions << successful_transactions
    invoice2.transactions << failed_transactions
    invoice.invoice_items << create_list(:invoice_item, 3, quantity: 3, unit_price: 400)
    invoice2.invoice_items << create_list(:invoice_item, 3, quantity: 3, unit_price: 400)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    result = JSON.parse(response.body)

    expect(result['revenue']).to eq("1.08")
  end
end
