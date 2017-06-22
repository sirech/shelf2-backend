FactoryGirl.define do
  factory :book do
    title { Faker::Book.title }
    year { Faker::Number.between(2010, 2017) }
    stars { Faker::Number.between(1, 5) }
    category { Book.categories.keys.sample }

    trait :with_description do
      description { Faker::Yoda.quote }
    end
  end
end
