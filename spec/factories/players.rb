FactoryGirl.define do
  factory :player do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthdate '1999-10-24'
    email { Faker::Internet.email }
    password 'password'
    phone_number '12025550118'
    activated_at { 2.months.ago }
    bank_account_number '12036355776'
    language :en

    avatar { fixture_file_upload('image.jpg', 'image/jpeg') }
  end
end
