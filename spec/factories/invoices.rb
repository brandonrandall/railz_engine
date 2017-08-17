FactoryGirl.define do
  factory :invoice do
    customer
    merchant
    status "shipped"

    trait :with_transactions do
      transient do
        transaction_count 3
      end

      after(:create) do |invoice, evaluator|
        invoice.transactions << create_list(:transaction, evaluator.transaction_count)
      end
    end
  end
end
