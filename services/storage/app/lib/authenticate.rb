class Authenticate
  extend T::Sig

  sig do params(context: T.anything).returns(T.anything) end
  def self.call(context:)
    user_id = context[:current_user_id]
    user_id.nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : nil
  end
end
