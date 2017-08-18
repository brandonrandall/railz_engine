require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    it{is_expected.to validate_presence_of(:name)}
    it{is_expected.to validate_presence_of(:description)}
  end

  describe 'instance methods' do
    describe '#best_day' do
      it "returns the most recent invoice with the most sales for the given item" do
        item = create(:item)
        invoice_1 = create(:invoice, created_at: "2012-03-22T03:55:09.000Z")
        invoice_2 = create(:invoice, created_at: "2011-03-22T03:55:09.000Z")
        transactions_1 = create_list(:transaction, 3, invoice_id: invoice_1.id)
        transactions_2 = create_list(:transaction, 3, invoice_id: invoice_2.id)
        invoice_items = create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice_1.id, quantity: 3)
        invoice_items2 = create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice_2.id, quantity: 2)

        result = item.best_day
        expect(result).to be_instance_of(Invoice)
      end
    end
  end
end
