FactoryBot.define do
  factory :url do
    full_url { Faker::Internet.url }
  end
end