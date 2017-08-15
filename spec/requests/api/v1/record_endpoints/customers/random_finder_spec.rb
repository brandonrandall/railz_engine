require 'rails_helper'

RSpec.describe 'Customer API Random' do
  it "should return a random customer" do
    created = create_list(:customer, 5)
    first_names = created.map do |customer|
      customer.first_name
    end

    get '/api/v1/customers/random.json'

    customer = JSON.parse(response.body)

    expect(first_names).to include(customer['first_name'])
  end
end
