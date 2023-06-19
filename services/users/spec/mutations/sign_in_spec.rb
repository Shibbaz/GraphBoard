# frozen_string_literal: true

require 'rails_helper'

module Mutations
    RSpec.describe SignInUser, type: :request do
        describe 'Sign in' do
            describe 'Mutation Success' do
                let(:user) do
                    create(:user)
                end

                let(:result) do
                    Mutations::SignInUser.new(object: nil, field: nil, context: { session: {} }).resolve(credentials: {
                                                                                                            email: user.email,
                                                                                                            password: user.password
                                                                                                          })
                end

                it 'Mutation does pass succesful' do
                    expect(result[:token].present?)
                    assert_equal result[:user], user
                end
            end

            describe 'Mutation Failure' do
                let(:user) do
                    create(:user)
                end

                it 'expects mutation to not pass, lack of credentials' do
                    not_loged_in = Mutations::SignInUser.new(object: nil, field: nil,
                                                                      context: { session: {} }).resolve(credentials: {})
                    assert_nil not_loged_in
                end

                it 'expects sign-in failure, wrong email' do
                    not_loged_in = Mutations::SignInUser.new(object: nil, field: nil,
                                                               context: { session: {} }).resolve(credentials: { email: 'wrong' })
                    assert_nil not_loged_in
                end

                it 'expects sign-in failure, wrong password' do
                    not_loged_in = Mutations::SignInUser.new(object: nil, field: nil,
                                                                  context: { session: {} }).resolve(credentials: {
                                                                                                  email: user.email, password: 'wrong'
                                                                                                    })
                    assert_nil not_loged_in
                end
            end
        end
    end
end