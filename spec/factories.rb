FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :project do
  	name "Lorem ipsum"
  	user
  end

  factory :log do
    float_entry 1
    log_date Date.current
    project
  end
end