require 'rails_helper'

RSpec.describe 'Transaction API' do
  it "returns all transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(3)
  end

  it 'returns a single transaction' do
    created = create(:transaction)

    get "/api/v1/transactions/#{created.id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction['credit_card_number']).to eq(created.credit_card_number)
  end
end
