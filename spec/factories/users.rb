FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { '12345a' }
    password_confirmation { password }
    last_name             { 'あイ羽' }
    first_name            { 'かキ区' }
    last_name_kana        { 'アイウ' }
    first_name_kana       { 'カキク' }
    birth_day             { Faker::Date.backward }
  end
end
