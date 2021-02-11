FactoryGirl.define do
  factory :consultant do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'password'
  end
end
