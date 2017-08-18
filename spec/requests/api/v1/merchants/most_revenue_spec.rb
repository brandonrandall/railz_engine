require 'rails_helper'

describe "Merchants most revenue API" do
  it "returns the top (x) merchants ranked by total revenue" do

    merch1, merch2 = create_list(:merchant, 2)
    first_invoice = create(:invoice, merchant: merch1)
    second_invoice = create(:invoice, merchant: merch2)
    tx1 = create(:transaction, invoice: first_invoice, result: "success")
    tx2 = create(:transaction, invoice: second_invoice, result: "success")
    inv_itm1 = create(:invoice_item, invoice: second_invoice, quantity: 1)
    inv_itm2 = create(:invoice_item, invoice: second_invoice, quantity: 20000)
    inv_itm3 = create(:invoice_item, invoice: first_invoice, quantity: 3)

    # get "/api/v1/merchants/most_revenue?quantity=2"
    get "/api/v1/merchants/most_revenue", params: {quantity: 2}

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(2)
    expect(merchants.first['id']).to eq(merch2.id)
  end
end
