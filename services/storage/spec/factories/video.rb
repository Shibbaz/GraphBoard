FactoryBot.define do
    factory :video do
        id { SecureRandom.uuid }
        name { "One Piece" }
        description { Faker::JapaneseMedia::OnePiece.quote }
        type { "video" }
        author { SecureRandom.uuid }
        rules { [{ age: 12 }] }
    end
end