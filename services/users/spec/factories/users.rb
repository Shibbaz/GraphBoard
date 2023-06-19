FactoryBot.define do
  factory :user do
    id { SecureRandom.uuid }
    name { Faker::Name.name }
    surname { Faker::Name.name }
    phone { 123456789 }
    description { "LoremIpsumLoremIpsumLoremIpsumLoremIpsumLoremIpsumLoremIpsumLoremIpsum" }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    technologies { [{ name: "Ruby" }] }
    birthday { Faker::Date.birthday }
  end
end
