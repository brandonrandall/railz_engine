require 'rails_helper'

RSpec.describe 'Customer API Finders' do
  it "can find a single customer by first_name" do
    customers = create_list(:customer, 3)

    get '/api/v1/customers/find', params: {first_name: customers.first.first_name}

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer['first_name']).to eq(customers.first.first_name)
    expect(customer['last_name']).to eq(customers.first.last_name)
  end

  it "can find a single customer by last_name" do
    customers = create_list(:customer, 3)

    get '/api/v1/customers/find', params: {last_name: customers.first.last_name}

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer['first_name']).to eq(customers.first.first_name)
    expect(customer['last_name']).to eq(customers.first.last_name)
  end

  it "can find a customer by created_at" do
    customers = create_list(:customer, 3)
    customer_1 = create(:customer, created_at: "2012-03-27 14:58:15")
    get '/api/v1/customers/find', params: {created_at: customer_1.created_at}

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer['first_name']).to eq(customer_1.first_name)
    expect(customer['last_name']).to eq(customer_1.last_name)
  end

  it "can find all matching customers by first_name" do
    create_list(:customer, 3, first_name: 'Bob')
    create(:customer, first_name: 'John')

    get '/api/v1/customers/find_all', params: {first_name: 'Bob'}

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(3)
    expect(customers.first['first_name']).to eq('Bob')
  end

  it "can find all matching customers by last_name" do
    create_list(:customer, 3, last_name: 'Johnson')
    create(:customer, last_name: 'Smith')

    get '/api/v1/customers/find_all', params: {last_name: 'Johnson'}

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(3)
    expect(customers.first['last_name']).to eq('Johnson')
  end

  it "can find all matching customers by created_at" do
    created = create_list(:customer, 3, created_at: "2012-03-27 14:58:15")
    create(:customer, created_at: "2013-03-27 14:58:15")

    get '/api/v1/customers/find_all', params: {created_at: "2012-03-27 14:58:15"}

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(3)
    customers.each_with_index do |customer, index|
      expect(customer['first_name']).to eq(created[index].first_name)
      expect(customer['last_name']).to eq(created[index].last_name)
    end
  end
end
