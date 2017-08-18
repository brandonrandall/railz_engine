require 'rails_helper'

RSpec.describe 'Item best_day' do
  it "returns the best day by quantity sold" do
    item = create(:item)
    invoice_1 = create(:invoice, created_at: "2012-03-22T03:55:09.000Z")
    invoice_2 = create(:invoice, created_at: "2012-03-22T03:55:09.000Z")
    invoice_3 = create(:invoice, created_at: "2011-03-22T03:55:09.000Z")
    transactions_1 = create_list(:transaction, 3, invoice_id: invoice_1.id)
    transactions_2 = create_list(:transaction, 3, invoice_id: invoice_2.id)
    invoice_items = create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice_1.id, quantity: 3)
    invoice_items2 = create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice_2.id, quantity: 2)

    get "/api/v1/items/#{item.id}/best_day"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['best_day'].to_date).to eq invoice_1.created_at.to_date
  end
end
