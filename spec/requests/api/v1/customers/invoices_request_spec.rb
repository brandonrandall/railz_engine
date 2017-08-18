require 'rails_helper'

describe "Customers API" do
  it "can return associated invoices" do
    customer = create(:customer)
    create_list(:invoice, 4, customer_id: customer.id)
    create_list(:invoice, 3)

    get "/api/v1/customers/#{customer.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices).to be_a(Array)
    expect(invoices.count).to eq(4)
  end
end
