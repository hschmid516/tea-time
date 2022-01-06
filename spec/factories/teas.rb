FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { Faker::Number.within(range: 175..212) }
    brew_time { Faker::Number.within(range: 3.0..8.0) }
  end
end
