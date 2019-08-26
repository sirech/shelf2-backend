FactoryGirl.define do
  factory :book do
    title { Faker::Book.title }
    year { Faker::Number.between(from: 2010, to: 2017) }
    stars { Faker::Number.between(from: 1, to: 5) }
    category { Book.categories.keys.sample }

    trait :with_description do
      description { Faker::Yoda.quote }
    end
  end
end
