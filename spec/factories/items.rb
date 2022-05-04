FactoryBot.define do
  factory :item do
    product_name { Faker::Commerce.product_name }
    product_description { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 2, to: 21) }
    condition_id { Faker::Number.between(from: 2, to: 8) }
    shipping_fee_id { Faker::Number.between(from: 2, to: 4) }
    prefecture_id   { Faker::Number.between(from: 2, to: 48) }
    days_to_ship_id { Faker::Number.between(from: 2, to: 3) }
    price       { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
