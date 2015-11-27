FactoryGirl.define do
  factory :comment do
    user
    report
    content 'content'
  end

  factory :subscription do
    user
    report
  end

  factory :image do
    user nil
    image "MyString"
  end

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
    user
  end
end
