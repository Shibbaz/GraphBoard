require "rails_helper"

RSpec.describe Concepts::Tags::Repository, type: :request do
  subject(:repository) { Concepts::Tags::Repository.new }
  let(:informations) do
    {
      name: Faker::ProgrammingLanguage.name
    }
  end

  describe "method create" do
    it "expects to create tag successfully" do
      event = repository.create(
        informations: informations
      )
      expect(event).to(have_published(TagWasCreated))
    end

    it "expects not to create tag" do
      expect {
        repository.create(
          informations: {}
        )
      }.to raise_error(ArgumentError, "Please, pass params. Params not found")
    end
  end

  describe "method delete" do
    let(:tag) {
      create(:technology_tag)
    }

    it "expects to delete tag successfully" do
      event = repository.delete(
        tag_id: tag.id
      )
      expect(event).to(have_published(TagWasDeleted))
      expect { tag.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "expects to delete non-existing tag" do
      expect {
        repository.delete(
          tag_id: SecureRandom.uuid
        )
      }.to raise_error(
        ActiveRecord::RecordNotFound
      )
    end
  end

  describe "method update" do
    let(:tag) { create(:technology_tag) }

    let(:informations) {
      {
        name: "New Tag Name"
      }
    }

    it "expects to update tag successfully" do
      event = repository.update(
        tag_id: tag.id,
        informations: informations
      )
      expect(event).to(have_published(TagWasUpdated))
      tag.reload
      expect(tag.name).to eq("New Tag Name")
    end

    it "expects to update non-existing tag" do
      expect {
        repository.update(
          tag_id: SecureRandom.uuid,
          informations: informations
        )
      }.to raise_error(
        ActiveRecord::RecordNotFound
      )
    end
  end
end
