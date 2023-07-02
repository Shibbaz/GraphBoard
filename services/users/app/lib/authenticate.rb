class Authenticate
    extend T::Sig

    sig do params(context: T.anything).returns(T.anything) end
    def self.call(context:)
        user = context[:current_user]
        user.nil? ? (raise GraphQL::ExecutionError, 'Authentication Error') : nil
    end
end