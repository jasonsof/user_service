FactoryBot.define do
  factory :user_session do
    token { "MyString" }
    user
  end
end
