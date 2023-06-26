class Authenticate
    def self.call(context:)
        user = context[:current_user]
        user.nil? ? (raise GraphQL::ExecutionError, 'Authentication Error') : nil
    end
end