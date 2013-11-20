FactoryGirl.define do
  factory :user do
    name "Dev User"
    email "someone@example.com"
    password "somepass1"
    password_confirmation "somepass1"

    factory :admin_user do
      admin true
    end
  end
end