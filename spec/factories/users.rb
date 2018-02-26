FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@gmail.com"
  end
  # Or simply use Faker with random data
  
  factory :user do
    first_name "John"
    last_name "Snow"
    email { generate :email }
    password "abcd123"
    password_confirmation "abcd123"
  end
  factory :admin_user, class: "AdminUser" do
    first_name "Admin"
    last_name "Admin"
    email { generate :email }
    password "abcd123"
    password_confirmation "abcd123"
  end
end
