require "rails_helper"

RSpec.describe Concepts::Offers::Repository, type: :request do
  subject(:repository) { Concepts::Offers::Repository.new }
  let(:informations) do
    {
      name: "Ruby Developer",
      description: "This is offer for Ruby developer MID level",
      requirements: [
        details: {
          technology: Faker::ProgrammingLanguage.name,
          experience: 10,
          seniority: "MID"
        },
        work_environment: {
          remote: true,
          office: true,
          hybrid: true
        }
      ],
      tags: [create(:technology_tag).id],
      contact_details: {
        company_name: Faker::Company.name,
        industry: Faker::Company.industry,
        recruiter_name: Faker::Name.name,
        email: Faker::Internet.email
      },

      candidates: []

    }
  end

  describe "method create" do
    it "expects to create offer successfully" do
      event = repository.create(
        informations: informations,
        current_user_id: SecureRandom.uuid
      )
      expect(event).to(have_published(OfferWasCreated))
    end

    it "expects to raise type error " do
      expect{repository.create(informations: 6, current_user_id: 0.6)}.to raise_error(TypeError)
    end

    it "expects not to create offer" do
      expect {
        repository.create(
          informations: {},
          current_user_id: SecureRandom.uuid
        )
      }.to raise_error(ArgumentError, "Please, pass params. Params not found")
    end
  end

  describe "method delete" do
    let(:offer) {
      create(:offer)
    }
    let(:mocked_current_user_id) {
      offer.author
    }

    it "expects to delete offer successfully" do
      event = repository.delete(
        current_user_id: mocked_current_user_id,
        offer_id: offer.id
      )
      expect(event).to(have_published(OfferWasDeleted))
      expect { offer.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "expects to raise type error " do
      expect{repository.delete(current_user_id: 0.6, offer_id: 0.6)}.to raise_error(TypeError)
    end

    it "expects to delete non-existing offer" do
      expect {
        repository.delete(
          current_user_id: mocked_current_user_id,
          offer_id: SecureRandom.uuid
        )
      }.to raise_error(
        ActiveRecord::RecordNotFound
      )
    end
  end

  describe "method update" do
    let(:offer) { create(:offer) }
    let(:mocked_current_user_id) {
      offer.author
    }
    let(:informations) {
      {
        name: "New Name"
      }
    }

    it "expects to update offer successfully" do
      event = repository.update(
        current_user_id: mocked_current_user_id,
        offer_id: offer.id,
        informations: informations
      )
      expect(event).to(have_published(OfferWasUpdated))
      offer.reload
      expect(offer.name).to eq("New Name")
    end

    it "expects to raise type error " do
      expect{repository.update(current_user_id: 0.6, offer_id: 0.6, informations: 0.6)}.to raise_error(TypeError)
    end

    it "expects to update non-existing offer" do
      expect {
        repository.update(
          current_user_id: SecureRandom.uuid,
          offer_id: SecureRandom.uuid,
          informations: informations
        )
      }.to raise_error(
        ActiveRecord::RecordNotFound
      )
    end
  end
end
