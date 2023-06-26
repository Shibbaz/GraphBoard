RSpec.describe Mutations::DeleteTag, type: :request do
  let(:tag) { create(:technology_tag) }

  describe "Mutation Success" do
    it "expects to delete tag successfully" do
      mutation = Mutations::DeleteTag.new(object: nil, field: nil, context: {
        current_user_id: SecureRandom.uuid
      }).resolve(tag_id: tag.id)
      expect(mutation[:status]).to eq(200)
    end

    it "expects to fail deleting tag" do
      expect(Mutations::DeleteTag.new(object: nil, field: nil, context: {
        current_user_id: nil
      }).resolve(tag_id: tag.id)).to eq(GraphQL::ExecutionError.new("Authentication Error"))
    end
  end
end
