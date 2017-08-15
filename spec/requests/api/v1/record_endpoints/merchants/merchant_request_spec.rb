require 'rails_helper'

RSpec.describe 'Merchant API' do
  it 'can return all merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(3)
  end

  it 'can return a single merchant' do
    merch = create(:merchant)

    get "/api/v1/merchants/#{merch.id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant['name']).to eq(merch.name)
  end
end
