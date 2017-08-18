FactoryGirl.define do
  factory :invoice_item do
    item
    invoice
    unit_price 100
    quantity 5000
  end
end
