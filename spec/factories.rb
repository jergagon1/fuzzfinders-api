FactoryGirl.define do
  factory :article_tag do
  end

  factory :remark do
  end

  factory :article do
  end

  factory :user do
    sequence(:username) { |n| "username_#{n}" }
    sequence(:email) { |n| "username@mail#{n}.com" }

    password              'username@mail.com'
    password_confirmation 'username@mail.com'
  end

  factory :report do
    pet_name "Rebecca"
    animal_type "Micropig"
    user_id 1
  end
end
