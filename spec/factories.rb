FactoryGirl.define do
  factory :piece do
  end

<<<<<<< HEAD
  factory :user do
    name 'chessy'
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
=======
  factory :game do
  end

  factory :user do
    sequence :email do |_n|
      'dummyEmail#{_n}@gmail.com'
>>>>>>> display_pieces
    end
    password 'secretPassword'
    password_confirmation 'secretPassword'
  end
end
