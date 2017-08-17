require 'rails_helper'

RSpec.describe 'Item Relationship Endpoints' do
  it "can find the associated invoice_items" do
    item = create(:item)
    create_list(:invoice_item, 3, item_id: item.id)
    create(:invoice_item)

    get "/api/v1/items/#{item.id}/invoice_items"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(3)
    result.each do |invoice_item|
      expect(invoice_item['item_id']).to eq(item.id)
    end
  end

  it "can find the associated merchant" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['name']).to eq(merchant.name)
  end
end
