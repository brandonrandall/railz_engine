FactoryGirl.define do
  factory :transaction do
    credit_card_number { Faker::Number.number(10) }
    credit_card_expiration_date { Faker::Date.between(2.years.ago, Date.today) }
    result 'success'
    # customer
    invoice
  end
end
