require 'rails_helper'

RSpec.describe 'Transaction API' do
  it "returns all transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(3)
  end
end
