FactoryGirl.define do
  factory :piece do
  end

  factory :game do
  end

  factory :user do
    name 'chessy'
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password 'secretPassword'
    password_confirmation 'secretPassword'
  end
end
