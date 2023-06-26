RSpec.describe Mutations::UpdateTag, type: :request do
  let(:tag) { create(:technology_tag) }

  describe "Mutation Success" do
    it "expects to update tag successfully" do
      mutation = Mutations::UpdateTag.new(object: nil, field: nil, context: {
        current_user_id: SecureRandom.uuid
      }).resolve(
        tag_id: tag.id,
        informations: {
          name: "args"
        }
      )
      expect(mutation[:status]).to eq(200)
      tag.reload
      expect(tag.name).to eq("args")
    end

    it "expects to fail deleting tag" do
      expect {
        Mutations::UpdateTag.new(object: nil, field: nil, context: {
          current_user_id: nil
        }).resolve(tag_id: tag.id, informations: {})
      }.to raise_error(
        GraphQL::ExecutionError, "Authentication Error"
      )
    end
  end
end
