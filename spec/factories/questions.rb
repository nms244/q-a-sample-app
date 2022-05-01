FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyString" }
    solved { false }
    user { nil }
  end
end
