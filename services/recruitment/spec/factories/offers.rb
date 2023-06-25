FactoryBot.define do
  factory :offer do
    name { "Ruby Developer" }
    description { "This is offer for Ruby developer MID level" }
    requirements { [
      details: {
        technology: Faker::ProgrammingLanguage.name,
        experience: 10,
        seniority: "MID",
     },
      work_environment: {
        remote: true,
        office: true,
        hybrid: true
      }
    ]
    }
    tags { 
      tag = create(:technology_tag)
      [tag.id]
    }
    author { SecureRandom.uuid }
    contact_details {
      {
        company_name: Faker::Company.name,
        industry: Faker::Company.industry,
        recruiter_name: Faker::Name.name,
        email: Faker::Internet.email
      }
    }
    candidates{
      []
    }
  end
end
