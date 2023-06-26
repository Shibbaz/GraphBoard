FactoryBot.define do
  factory :technology_tag do
    name { Faker::ProgrammingLanguage.name }
  end
end
