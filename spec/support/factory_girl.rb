RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

FactoryGirl.define do

  factory :note_type do
    factory :public_note_type do
      id 1
      name 'public'
    end

    factory :private_note_type do
      id 2
      name 'private'
    end

    factory :paid_access_note_type do
      id 3
      name 'paid access'
    end
  end

  public_note_type = FactoryGirl.create(:public_note_type)
  private_note_type = FactoryGirl.create(:private_note_type)
  paid_access_note_type = FactoryGirl.create(:paid_access_note_type)

  factory :note do
    sequence(:id) { |n| n }
    title Faker::Name.title
    body Faker::Lorem.words
    note_type public_note_type
    association :user, factory: :user

    factory :paid_access_note do
      note_type paid_access_note_type
    end
  end

  factory :user do
    sequence(:id) { |n| n }
    sequence(:user_name) { |n| "username#{n}" }
    sequence(:email) { |n| "username#{n}@example.com" }
    password 'mysweetsecret123'
  end

  factory :payment do
    sequence(:id) { |n| n }
    sequence(:custom, 1000) { |n| "custom#{n}" }
    price 100
    association :user, factory: :user
    association :note, factory: :note

    trait :started do
      status Payment::STATUS_STARTED
    end

    trait :verified do
      status Payment::STATUS_VERIFIED
    end

    trait :completed do
      status Payment::STATUS_COMPLETED
    end

    trait :unsettled do
      settled false
    end

    trait :without_transaction_fee do
      transaction_fee nil
    end

    trait :with_transaction_fee do
      transaction_fee 0.1
    end

    factory :started_payment, traits: [:started]
    factory :verified_payment, traits: [:verified]
    factory :completed_payment, traits: [:completed]
    factory :completed_unsettled_payment, traits: [:completed, :unsettled]
    factory :completed_without_transaction_fee_payment, traits: [:completed, :without_transaction_fee]
    factory :completed_with_transaction_fee_payment, traits: [:completed, :with_transaction_fee]

  end

end