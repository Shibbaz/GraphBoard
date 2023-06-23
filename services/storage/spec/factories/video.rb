FactoryBot.define do
  factory :video do
    id { SecureRandom.uuid }
    name { "One Piece" }
    description { Faker::JapaneseMedia::OnePiece.quote }
    video_type { "video" }
    author { SecureRandom.uuid }
    rules { [{age: 12}] }
    created_at { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
