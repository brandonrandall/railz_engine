require 'rails_helper'

RSpec.describe 'Invoice Relationship Endpoints' do
  it "can find the associated transactions" do
    invoice = create(:invoice, :with_transactions, transaction_count: 3)
    create(:transaction)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    result = JSON.parse(response.body)
    expect(response).to be_success
    result.each do |transaction|
      expect(transaction['invoice_id']).to eq(invoice.id)
    end
  end
end
