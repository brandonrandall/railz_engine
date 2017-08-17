require 'rails_helper'

describe 'Transactions API' do
  it "can return all associated invoices" do

    tx = create(:transaction)
    inv = create(:invoice)
    tx.invoice_id = inv.id
    tx.save

    get "/api/v1/transactions/#{tx.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_success

    expect(invoice["id"]).to eq(tx.invoice.id)
    expect(invoice.count).to eq(4)
  end
end
