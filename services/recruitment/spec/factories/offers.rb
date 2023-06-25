name = Faker::ProgrammingLanguage.name
FactoryBot.define do
  factory :offer do
    name { "#{name} Developer" }
    description { "This is offer for #{name} developer MID level" }
    requirements { [{
      technologies: [{
        technology: name,
        experience: 10,
        seniority: "MID"
      }],
      type: {
        remote: true,
        office: true,
        hybrid: true
      }
      }
      ] }
    tags { create(:technology_tag, name: name) }
    author { SecureRandom.uuid }
    contact_details {
      {
        company_name: Faker::Company.name,
        industry: Faker::Company.industry,
        recruiter_name: Faker::Name.name,
        email: Faker::Internet.email
      }
     }
  end
end
