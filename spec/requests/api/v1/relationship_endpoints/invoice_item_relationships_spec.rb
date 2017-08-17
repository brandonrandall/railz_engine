require 'rails_helper'

RSpec.describe 'Invoice_Item Relationship Endpoints' do
  it "can find the associated invoice" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice_id: invoice.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['id']).to eq(invoice.id)
  end

  it "can find the associated item" do
    item = create(:item)
    invoice_item = create(:invoice_item, item_id: item.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['id']).to eq(item.id)
  end
end
