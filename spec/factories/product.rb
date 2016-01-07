require 'faker'

FactoryGirl.define do
  factory :product do |p|
    p.title { Faker::Name.title }
    
    p.price { Faker::Commerce.price }
   	p.category_id "1"
  end
end

