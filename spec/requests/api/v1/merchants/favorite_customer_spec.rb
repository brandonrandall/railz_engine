require 'rails_helper'

describe 'Merchants API' do
  it 'merchants can find its favorite customer' do
    #what defines the favorite customer?
    #customers with the most tx that are successful
    walmart = create(:merchant)
    first_customer, second_customer = create_list(:customer, 2)
    invoice1 = create(:invoice, merchant: walmart, customer: first_customer)
    invoice2 = create(:invoice, merchant: walmart, customer: second_customer)

    tx1 = create(:transaction, invoice: invoice1, result: 'success')
    tx2 = create(:transaction, invoice: invoice1, result: 'success')
    tx3 = create(:transaction, invoice: invoice2, result: 'success')
    inv_itm1 = create(:invoice_item, invoice: invoice1, quantity: 10)
    inv_itm2 = create(:invoice_item, invoice: invoice2, quantity: 1000)

    get "/api/v1/merchants/#{walmart.id}/favorite_customer"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer.class).to eq(Hash)
    expect(customer["id"]).to eq(first_customer.id)
  end
end
