FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password 'excellentpassword1'
  end
end
