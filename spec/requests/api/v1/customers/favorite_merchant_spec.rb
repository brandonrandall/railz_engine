require 'rails_helper'

RSpec.describe 'Customer favorite_merchant' do
  it "returns a merchant where the customer has conducted the most successful transactions" do
    customer = create(:customer)
    merchant_1, merchant_2 = create_list(:merchant, 2)
    invoices_1 = create(:invoice, :with_transactions, transaction_count: 3,
                        customer_id: customer.id,
                        merchant_id: merchant_1.id)
    invoices_2 = create(:invoice, :with_transactions, transaction_count: 6,
                        customer_id: customer.id,
                        merchant_id: merchant_2.id)

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    result = JSON.parse(response.body)

    expect(response).to be_success
  end
end
