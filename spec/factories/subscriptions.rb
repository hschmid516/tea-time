FactoryBot.define do
  factory :subscription do
    customer { nil }
    tea { nil }
    title { "MyString" }
    price { 1.5 }
    status { 0 }
    frequency { 1 }
  end
end
