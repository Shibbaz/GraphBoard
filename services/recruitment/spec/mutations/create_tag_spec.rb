RSpec.describe Mutations::CreateTag, type: :request do
  let(:informations) {
    {
      name: "Ruby"
    }
  }
  describe "Mutation Success" do
    it "expects to create tag successfully" do
      mutation = Mutations::CreateTag.new(object: nil, field: nil, context: {
        current_user_id: SecureRandom.uuid
      }).resolve(
        informations: informations
      )
      expect(mutation[:status]).to eq(200)
      expect(TechnologyTag.all.size).to eq(1)
      expect(TechnologyTag.first.name).to eq("Ruby")
    end

    it "expects to fail creating tag" do
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
