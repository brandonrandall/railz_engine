require 'rails_helper'

RSpec.describe 'Item most_items' do
  it "returns the top x items by number sold" do
    item = create(:item)
    invoice_1 = create(:invoice, created_at: "2012-03-22T03:55:09.000Z")
    transactions_1 = create_list(:transaction, 3, invoice_id: invoice_1.id)
    invoice_items = create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice_1.id, quantity: 1)

    item2 = create(:item)
    invoice_2 = create(:invoice, created_at: "2012-03-22T03:55:09.000Z")
    transactions_2 = create_list(:transaction, 3, invoice_id: invoice_2.id)
    invoice_items = create_list(:invoice_item, 3, item_id: item2.id, invoice_id: invoice_2.id, quantity: 100000000)

    item3 = create(:item)
    invoice_3 = create(:invoice, created_at: "2012-03-22T03:55:09.000Z")
    transactions_3 = create_list(:transaction, 3, invoice_id: invoice_3.id)
    invoice_items = create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice_3.id, quantity: 4)

    get '/api/v1/items/most_items', params: {quantity: 3}

    result = JSON.parse(response.body)

    expect(result.first['id']).to eq item2.id
  end
end
