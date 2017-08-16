require 'rails_helper'

describe "Invoice_items random" do
  it "can return random invoice item" do
    create_list(:invoice_item, 3)

    get "/api/v1/invoice_items/random.json"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(item.class).to be(Hash)
  end
end
