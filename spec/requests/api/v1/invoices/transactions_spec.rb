require 'rails_helper'

describe 'Invoices API' do
  it "can return all associated transactions" do

    tx = create_list(:transaction, 3)
    invoices = create_list(:invoice, 3)

    get "/api/v1/invoices/#{Invoice.first.id}/transactions"
    
    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice.first["invoice_id"]).to eq(Invoice.first.id)
    expect(invoice.count).to eq(3)
  end
end
