FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.email }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end