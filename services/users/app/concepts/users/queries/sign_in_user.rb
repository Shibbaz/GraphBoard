module Concepts
    module Users
        module Queries
            class SignInUser
                def self.call(credentials)
                    return unless credentials

                    user = User.find_by email: credentials[:email]
        
                    return unless user
                    return unless user.authenticate(credentials[:password])
        
                    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
                    token = crypt.encrypt_and_sign("user-id:#{user.id}")
                    { user:, token: }
                end
            end
        end
    end
end