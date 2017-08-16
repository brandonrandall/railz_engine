require 'rails_helper'

RSpec.describe 'Transaction API random' do
  it "returns a random transaction" do
    created = create_list(:transaction, 5)
    cc_nums = created.map do |transaction|
      transaction.credit_card_number
    end

    get '/api/v1/transactions/random.json'

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(cc_nums).to include(transaction["credit_card_number"])
  end
end
