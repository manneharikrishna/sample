class Admin::SessionsController < Admin::BaseController
  skip_before_action :authorize_request

  def create
    session = CreateSession.new(:operator, email, password).call
    render json: session, status: :created
  end

  private

  def email
    @email ||= params.require(:email)
  end

  def password
    @password ||= params.require(:password)
  end
end
