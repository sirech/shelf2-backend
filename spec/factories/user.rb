FactoryGirl.define do
  factory :user do
    name { Faker::Internet.user_name(8..12) }
    password { Faker::Internet.password }
  end
end
