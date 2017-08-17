require 'rails_helper'

describe 'Customers API' do
  it "can return associated transactions" do

    customer = create(:customer)
    # invoice_1, invoice_2 = create_list(:invoice, 2, customer_id: customer.id)
    create_list(:transaction, 4)
    create_list(:transaction, 6, customer_id: customer.id)
    get "/api/v1/customers/#{customer.id}/transactions"

    transactions = JSON.parse(response.body)

    # binding.pry
    expect(response).to be_success
    expect(transactions).to be_a(Array)
    expect(transactions.count).to eq(6)
  end
end
