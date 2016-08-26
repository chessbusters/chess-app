FactoryGirl.define do
  factory :piece do
  end

<<<<<<< HEAD
  factory :game do
  end
=======
  factory :user do
    name 'chessy'
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
>>>>>>> master
    end
    password 'secretPassword'
    password_confirmation 'secretPassword'
  end
end
