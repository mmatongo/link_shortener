FactoryBot.define do
  factory :url do
    full_url { Faker::Internet.url }
    short_url { SecureRandom.alphanumeric(5).upcase }
  end

  factory :visit do
    url
  end
end
