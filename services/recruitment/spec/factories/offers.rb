FactoryBot.define do
  factory :offer do
    name { "Ruby Developer" }
    description { "This is offer for Ruby developer MID level" }
    requirements { {
        technology: name,
        experience: 10,
        seniority: "MID",
        remote: true,
        office: true,
        hybrid: true
     } 
    }
    tags { 
      [create(:technology_tag, name: Faker::ProgrammingLanguage.name).id]
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
