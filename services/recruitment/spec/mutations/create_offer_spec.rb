RSpec.describe Mutations::CreateOffer, type: :request do
  let(:technology) {
    Faker::ProgrammingLanguage.name
  }

  let(:tag) {
    create(:technology_tag)
  }

  let(:current_user_id) {
    SecureRandom.uuid
  }

  let(:company_name) { Faker::Company.name }
  let(:industry) { Faker::Company.industry }
  let(:recruiter_name) { Faker::Name.name }
  let(:email) { Faker::Internet.email }

  let(:informations) {
    {
      name: "Ruby Developer",
      description: "This is offer for Ruby developer MID level",
      requirements: [
        details: {
          technology: technology,
          experience: 10,
          seniority: "MID"
        },
        work_environment: {
          remote: true,
          office: true,
          hybrid: true
        }
      ],
      tags: [tag.id],
      contact_details: {
        company_name: company_name,
        industry: industry,
        recruiter_name: recruiter_name,
        email: email
      },
      candidates: []
    }
  }
  describe "Mutation Success" do
    it "expects to create offer successfully" do
      mutation = Mutations::CreateOffer.new(object: nil, field: nil, context: {
        current_user_id: current_user_id
      }).resolve(
        informations: informations
      )
      expect(mutation[:status]).to eq(200)
      expect(Offer.all.size).to eq(1)
      offer = Offer.first
      expect(offer.name).to eq("Ruby Developer")
      expect(offer.description).to eq("This is offer for Ruby developer MID level")
      requirements = offer.requirements
      expect(requirements.size).to eq(1)
      expect(requirements[0]["details"]["technology"]).to eq(technology)
      expect(requirements[0]["details"]["experience"]).to eq(10)
      expect(requirements[0]["details"]["seniority"]).to eq("MID")
      expect(requirements[0]["work_environment"]["remote"]).to eq(true)
      expect(requirements[0]["work_environment"]["hybrid"]).to eq(true)
      expect(requirements[0]["work_environment"]["office"]).to eq(true)
      expect(offer.tags).to eq([tag.id])
      expect(offer.author).to eq(current_user_id)
      expect(offer.candidates.size).to eq(0)
      expect(offer.contact_details["company_name"]).to eq(company_name)
      expect(offer.contact_details["industry"]).to eq(industry)
      expect(offer.contact_details["recruiter_name"]).to eq(recruiter_name)
      expect(offer.contact_details["email"]).to eq(email)
    end

    it "expects to fail creating offer" do
      expect {
        Mutations::CreateTag.new(object: nil, field: nil, context: {
          current_user_id: nil
        }).resolve(informations: {})
      }.to raise_error(
        GraphQL::ExecutionError, "Authentication Error"
      )
    end
  end
end
