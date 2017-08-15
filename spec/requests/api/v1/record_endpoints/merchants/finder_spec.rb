require 'rails_helper'

RSpec.describe 'Merchant API Finders' do
  it "can find a single merchant by name" do
    merchants = create_list(:merchant, 3)

    get '/api/v1/merchants/find', params: {name: merchants.first.name}

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant['name']).to eq(merchants.first.name)
  end

  it "can find a merchant by created_at" do
    merchants = create_list(:merchant, 3)
    customer_1 = create(:merchant, created_at: "2012-03-27 14:58:15")
    get '/api/v1/merchants/find', params: {created_at: customer_1.created_at}

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant['name']).to eq(customer_1.name)
  end

  it "can find all matching merchants by name" do
    create_list(:merchant, 3, name: 'Bob')
    create(:merchant, name: 'John')

    get '/api/v1/merchants/find_all', params: {name: 'Bob'}

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(3)
    expect(merchants.first['name']).to eq('Bob')
  end

  it "can find all matching merchants by created_at" do
    created = create_list(:merchant, 3, created_at: "2012-03-27 14:58:15")
    create(:merchant, created_at: "2013-03-27 14:58:15")

    get '/api/v1/merchants/find_all', params: {created_at: "2012-03-27 14:58:15"}

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(3)
    merchants.each_with_index do |merchant, index|
      expect(merchant['name']).to eq(created[index].name)
    end
  end
end
