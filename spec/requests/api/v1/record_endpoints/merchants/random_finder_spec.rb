require 'rails_helper'

RSpec.describe 'Merchant API Random' do
  it 'returns a random record' do
    created = create_list(:merchant, 5)
    names = created.map do |merchant|
      merchant.name
    end

    get '/api/v1/merchants/random.json'

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(names).to include(merchant["name"])
  end
end
