require 'rails_helper'

descritb "Merchants API" do
  it "can return associated invoices" do
    merchant = create(:merchant)
    create_list(:invoice, 4, merchant_id: merchant.id)
    create_list(:invoice, 3)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices).to be_a(Array)
    expect(invoices.count).to eq(4)
  end
end
