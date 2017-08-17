require 'rails_helper'

describe 'Merchant items' do
#   it 'finds all items for a single merchant' do
#     merch = create(:merchant)
#
#     item1,item2,item3 = create_list(:item, 3, merchant: merch)
#
#     get "/api/v1/merchants/#{merch.id}/items"
#
#     expect(response).to be_success
#
#     items = JSON.parse(response.body)
#
#     expect(items.count).to eq(3)
#     expect(items.first["id"]).to eq(item1.id)
#   end

  it "can return associated items" do
    merchant = create(:merchant)
    create_list(:item, 4)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"
    # binding.pry

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items).to be_a(Array)
    expect(items.count).to eq(3)
  end
end
