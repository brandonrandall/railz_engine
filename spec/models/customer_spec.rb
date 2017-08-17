require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe "validations" do
    it{is_expected.to validate_presence_of(:first_name)}
    it{is_expected.to validate_presence_of(:last_name)}
  end

  describe 'instance methods' do
    describe '#favorite_merchant' do
      it "returns the merchant where the customer has conducted the most successful transactions" do
        customer = create(:customer)
        merchant_1, merchant_2 = create_list(:merchant, 2)
        invoices_1 = create(:invoice, :with_transactions, transaction_count: 1,
                            customer_id: customer.id,
                            merchant_id: merchant_1.id)
        invoices_2 = create(:invoice, :with_transactions, transaction_count: 6,
                            customer_id: customer.id,
                            merchant_id: merchant_2.id)

        result = customer.favorite_merchant

        expect(result.name).to eq(merchant_2.name)
      end
    end
  end
end
