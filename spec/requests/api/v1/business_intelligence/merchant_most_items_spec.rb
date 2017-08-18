require 'rails_helper'

RSpec.describe 'Merchant API Most Items' do
  it "should return the top x merchants by revenue" do
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

    get '/api/v1/merchants/most_items', params: {quantity: 2}

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(2)
    expect(result.first['id']).to eq(merchant2.id)
    expect(result.last['id']).to eq(merchant3.id)
  end
end
