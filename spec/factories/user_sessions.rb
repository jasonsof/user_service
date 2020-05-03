FactoryBot.define do
  factory :user_session do
    user_id { 1 }
    token { "MyString" }
  end
end
