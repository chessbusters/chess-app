FactoryGirl.define do
  factory :piece do
  end

  factory :game do
  end

  factory :user do
    sequence :email do |_n|
      'dummyEmail#{_n}@gmail.com'
    end
    password 'secretPassword'
    password_confirmation 'secretPassword'
  end
end
