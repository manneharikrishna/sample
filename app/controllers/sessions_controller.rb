class SessionsController < BaseController
  skip_before_action :authorize_request
  skip_before_action :ensure_player_activated

  def create
    session = CreateSession.new(:player, email, password).call
    render json: session, include: include, status: :created
  end

  private

  def email
    @email ||= params.require(:email)
  end

  def password
    @password ||= params.require(:password)
  end

  def include
    [:limits, { player: :avatar }]
  end
end
