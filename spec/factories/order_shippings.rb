FactoryBot.define do
  factory :order_shipping do
    postcode { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { '名古屋市' }
    block { '中区錦11-21' }
    building { 'アパート201号' }
    phone_number { '0520000000' }
    token { 'tok_abcdefghijk00000000000000000' }
    association :user, :item
  end
end
