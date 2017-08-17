require 'rails_helper'

describe 'Customers API' do
  it "can return associated transactions" do
    customer = create(:customer)
    invoice = create(:invoice, :with_transactions, transaction_count: 6, customer_id: customer.id)

    get "/api/v1/customers/#{customer.id}/transactions"

    transactions = JSON.parse(response.body)

    # binding.pry
    expect(response).to be_success
    expect(transactions).to be_a(Array)
    expect(transactions.count).to eq(6)
  end
end
