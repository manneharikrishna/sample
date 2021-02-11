class Admin::PasswordResetsController < Admin::BaseController
  skip_before_action :authorize_request

  def create
    submit_form(PasswordResetForm.new(Operator.new))
  end

  def update
    operator = ResetPassword.new(:operator, token, new_password).call

    if operator.errors.present?
      render_errors(operator)
    else
      head :ok
    end
  end

  private

  def token
    @token ||= params.require(:token)
  end

  def new_password
    @new_password ||= params.require(:new_password)
  end
end
