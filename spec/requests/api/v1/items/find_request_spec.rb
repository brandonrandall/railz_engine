require 'rails_helper'

RSpec.describe "Items find API" do
  describe "Item params returns single record" do
    it "can find item by id" do
      items = create_list(:item, 3)

      get "/api/v1/items/find?id=#{items.first.id}"
      expect(response).to be_success

      item = JSON.parse(response.body)
      expect(item["id"]).to eq(items.first.id)
    end
  end

    it "can find item by name" do
      items = create_list(:item, 3)

      get "/api/v1/items/find?name=#{items.first.name}"
      expect(response).to be_success

      item = JSON.parse(response.body)

      expect(item["id"]).to eq(items.first.id)
    end

    it "can find item by description" do
      items = create_list(:item, 3)

      get "/api/v1/items/find?description=#{items.first.description}"

      expect(response).to be_success

      item = JSON.parse(response.body)

      expect(item["id"]).to eq(items.first.id)
    end
#
    it "can find item by unit price" do
      items = create_list(:item, 3)
      unit_price= "1.00"
      get "/api/v1/items/find?unit_price=#{unit_price}"

      expect(response).to be_success

      item = JSON.parse(response.body)

      expect(item["id"]).to eq(items.first.id)
    end
#
  it "can find all items by created_at" do
    create(:merchant, id: 1)
    item1 = Item.create(name: "item1", description: "This is item 1", unit_price: 1200, created_at: "2017-05-01 18:06:59", updated_at: "2017-05-01 18:06:59", merchant_id: 1)
    item2 = Item.create(name: "item1", description: "This is item 2", unit_price: 1200, created_at: "2017-05-01 18:06:59", updated_at: "2017-05-01 18:06:59", merchant_id: 1)
    item3 = Item.create(name: "item3", description: "This is item 3", unit_price: 1200, created_at: "2017-05-03 18:06:59", updated_at: "2017-05-01 18:06:59", merchant_id: 1)

    get "/api/v1/items/find_all?created_at=#{item1.created_at}"

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(item1.id)
  end

  it "can find all items by updated at" do
    create(:merchant, id: 1)
    item1 = Item.create(name: "item1", description: "This is item 1", unit_price: 1200, created_at: "2017-05-01 18:06:59", updated_at: "2017-05-01 18:06:59", merchant_id: 1)
    item2 = Item.create(name: "item1", description: "This is item 2", unit_price: 1200, created_at: "2017-05-01 18:06:59", updated_at: "2017-05-03 18:06:59", merchant_id: 1)
    item3 = Item.create(name: "item3", description: "This is item 3", unit_price: 1200, created_at: "2017-05-01 18:06:59", updated_at: "2017-05-01 18:06:59", merchant_id: 1)

    get "/api/v1/items/find_all?updated_at=#{item1.updated_at}"

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(item1.id)
  end
end
