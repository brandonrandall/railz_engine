require 'rails_helper'

RSpec.describe 'Invoice Relationship Endpoints' do
  it "can find the associated transactions" do
    invoice = create(:invoice, :with_transactions, transaction_count: 3)
    create(:transaction)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(3)
    result.each do |transaction|
      expect(transaction['invoice_id']).to eq(invoice.id)
    end
  end

  it "can find the associated invoice_items" do
    invoice = create(:invoice, :with_invoice_items, invoice_item_count: 3)
    create(:invoice_item)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(3)
    result.each do |invoice_item|
      expect(invoice_item['invoice_id']).to eq(invoice.id)
    end
  end

  it "can find the associated items" do
    invoice = create(:invoice, :with_invoice_items, invoice_item_count: 3)
    other_item = create(:item)

    get "/api/v1/invoices/#{invoice.id}/items"

    result = JSON.parse(response.body)

    item_ids = result.map do |item|
      item["id"]
    end

    expect(response).to be_success
    expect(result.count).to eq(3)
    expect(item_ids).to include(invoice.items.first.id)
    expect(item_ids).to_not include(other_item.id)
  end

  it "can find the associated merchant" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['name']).to eq(merchant.name)
  end

  it "can find the associated customer" do
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id)

    get "/api/v1/invoices/#{invoice.id}/customer"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['first_name']).to eq(customer.first_name)
  end
end
