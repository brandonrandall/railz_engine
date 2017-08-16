require 'rails_helper'

describe "Invoices random" do
  it "can return random invoice" do
    create_list(:invoice, 3)

    get "/api/v1/invoices/random.json"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(item.class).to be(Hash)
  end
end
