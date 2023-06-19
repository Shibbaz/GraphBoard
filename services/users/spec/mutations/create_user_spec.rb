# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateUser, type: :request do
  let(:email) do
    Faker::Internet.email
  end

  let(:auth_provider) do
    {
        email: Faker::Internet.email,
        password: Faker::Internet.password
    }
  end

  let(:informations) do
    {
        name: "kamil",
        surname: "Mosciszko",
        birthday: "03/09/1997",
        phone: 667089180,
        description: Faker::String.random(length: 50),
        technologies: [{
          name: "Ruby",
          experience: "2 years"
        }]
    }
  end

  describe 'Mutation Success' do
    it 'expects to create user successfully' do
      user = Mutations::CreateUser.new(object: nil, field: nil, context: {}).resolve(
        informations: informations,
        auth_provider:,
      )
    end
  end

  describe 'Mutation Failure' do
    it 'expects to not create user' do
      expect { Mutations::CreateUser.new(object: nil, field: nil, context: {
      }).resolve(
        informations: {},
        auth_provider: {}
      )}.to raise_error(GraphQL::ExecutionError)
    end
  end
end