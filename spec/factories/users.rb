FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    password_confirmation { password }
  end
end
