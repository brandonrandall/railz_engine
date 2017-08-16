require 'rails_helper'

RSpec.describe 'Transaction API Finder' do
  it "can find a single transaction by credit_card_number" do
    transactions = create_list(:transaction, 3)

    get '/api/v1/transactions/find', params: {credit_card_number: transactions.first.credit_card_number}

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction['credit_card_number']).to eq(transactions.first.credit_card_number)
  end

  it "can find a transaction by created_at" do
    transactions = create_list(:transaction, 3)
    transaction_1 = create(:transaction, created_at: "2012-03-27 14:58:15")
    get '/api/v1/transactions/find', params: {created_at: transaction_1.created_at}

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction['credit_card_number']).to eq(transaction_1.credit_card_number)
  end

  it "can find a transaction by invoice_id" do
    transactions = create_list(:transaction, 3)

    get '/api/v1/transactions/find', params: {invoice_id: transactions[0].invoice_id}

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction['invoice_id']).to eq(transactions[0].invoice_id)
  end

  it "can find a transaction by result" do
    transactions = create_list(:transaction, 3)

    get '/api/v1/transactions/find', params: {result: transactions[0].result}

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction['result']).to eq(transactions[0].result)
  end

  it "can find all matching transactions by credit_card_number" do
    create_list(:transaction, 3, credit_card_number: 199291923)
    create(:transaction)

    get '/api/v1/transactions/find_all', params: {credit_card_number: 199291923}

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(3)
    expect(transactions.first['credit_card_number']).to eq(199291923)
  end

  it "can find all matching transactions by created_at" do
    created = create_list(:transaction, 3, created_at: "2012-03-27 14:58:15")
    create(:transaction, created_at: "2013-03-27 14:58:15")

    get '/api/v1/transactions/find_all', params: {created_at: "2012-03-27 14:58:15"}

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(3)
    transactions.each_with_index do |transaction, index|
      expect(transaction['credit_card_number']).to eq(created[index].credit_card_number)
    end
  end
end
