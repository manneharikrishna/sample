class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit

  rescue_from Pundit::NotAuthorizedError do
    head :forbidden
  end

  rescue_from ResponseError do |exception|
    errors = { errors: [exception.message] }
    render json: errors, status: exception.status
  end

  rescue_from ActionController::ParameterMissing, with: :render_message

  private

  def authorize(record, object = record, query = nil)
    policy_class = PolicyFinder.new(object).policy
    policy = policy_class.new(pundit_user, record)

    unless policy.public_send(query || "#{action_name}?")
      raise Pundit::NotAuthorizedError
    end
  end

  def submit_form(form, status = :created)
    if form.validate(params.to_unsafe_hash)
      form.save
      render json: form.model, status: status
    else
      render_errors(form)
    end
  end

  def render_errors(object)
    errors = { errors: object.errors.to_a }
    render json: errors, status: :bad_request
  end

  def render_message(exception)
    render json: exception.message, status: :bad_request
  end
end
