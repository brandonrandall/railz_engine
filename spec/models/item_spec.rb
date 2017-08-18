require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    it{is_expected.to validate_presence_of(:name)}
    it{is_expected.to validate_presence_of(:description)}
  end

  describe 'associations' do
    it {is_expected.to belong_to(:merchant)}
    it {is_expected.to have_many(:invoice_items)}
    it {is_expected.to have_many(:invoices).through(:invoice_items)}
  end

  describe 'instance methods' do
    describe '#best_day' do
      it "returns the most recent invoice with the most sales for the given item" do
        item = create(:item)
        invoice_1 = create(:invoice, created_at: "2012-03-22T03:55:09.000Z")
        invoice_2 = create(:invoice, created_at: "2011-03-22T03:55:09.000Z")
        transactions_1 = create_list(:transaction, 3, invoice_id: invoice_1.id)
        transactions_2 = create_list(:transaction, 3, invoice_id: invoice_2.id)
        invoice_items = create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice_1.id, quantity: 10000)
        invoice_items2 = create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice_2.id, quantity: 2)

        result = item.best_day
        expect(result).to be_instance_of(Invoice)
      end
    end
  end

  describe 'class methods' do
    describe '.most_items' do
      it "should return the top x items by number sold" do

        item = create(:item)
        invoice_1 = create(:invoice,
                            created_at: "2012-03-22T03:55:19.000Z")
        transactions_1 = create_list(:transaction,
                                      3,
                                      invoice_id: invoice_1.id)
        invoice_items = create_list(:invoice_item,
                                      3,
                                      item_id: item.id,
                                      invoice_id: invoice_1.id,
                                      quantity: 1)

        item2 = create(:item)
        invoice_2 = create(:invoice, created_at: "2012-03-22T03:55:09.000Z")
        transactions_2 = create_list(:transaction, 3, invoice_id: invoice_2.id)
        invoice_items = create_list(:invoice_item, 3, item_id: item2.id, invoice_id: invoice_2.id, quantity: 100000)

        item3 = create(:item)
        invoice_3 = create(:invoice, created_at: "2012-03-22T03:55:29.000Z")
        transactions_3 = create_list(:transaction, 3, invoice_id: invoice_3.id)
        invoice_items = create_list(:invoice_item, 3, item_id: item3.id, invoice_id: invoice_3.id, quantity: 4)

        result = Item.most_items(3)
        # binding.pry
        expect(result).to include item2
      end
    end
  end
end
