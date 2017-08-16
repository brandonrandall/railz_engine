require 'rails_helper'

describe "Items random" do
  it "can return random item" do
    create_list(:item, 3)

    get "/api/v1/items/random.json"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(item.class).to be(Hash)
  end
end
