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
end
