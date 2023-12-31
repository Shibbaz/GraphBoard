class GraphqlController < ApplicationController
  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user_id: current_user_id,
      session: session,
      tracing_enabled: ApolloFederation::Tracing.should_add_traces(
        request.headers
      )

    }
    result = RecruitmentsSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name
    )
    render json: result
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: {errors: [{message: e.message, backtrace: e.backtrace}], data: {}}, status: 500
  end

  def current_user_id
    return if request.env["HTTP_AUTHORIZATION"] == "undefined" || request.env["HTTP_AUTHORIZATION"].nil?
    crypt = ActiveSupport::MessageEncryptor.new(
      Rails.application.credentials.users_service_secret_key_base.byteslice(0..31)
    )
    token = crypt.decrypt_and_verify request.env["HTTP_AUTHORIZATION"]
    token.gsub("user-id:", "")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end
end
