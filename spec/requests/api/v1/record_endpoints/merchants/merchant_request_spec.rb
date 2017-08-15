require 'rails_helper'

RSpec.describe 'Merchant API' do
  it 'can return all merchants' do
    merchants_c = create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(3)
  end
end
