require 'faker'

FactoryGirl.define do
  factory :post do
    date Date.today
    rationale "Some Rationale Post1"
  end
  factory :second_post, class: "Post" do
    date Date.yesterday
    rationale "Some Rationale Post2"
  end
end
