class PasswordResetsController < BaseController
  skip_before_action :authorize_request
  skip_before_action :ensure_player_activated

  def create
    submit_form(PasswordResetForm.new(Player.new))
  end

  def update
    player = ResetPassword.new(:player, token, new_password).call

    if player.errors.present?
      render_errors(player)
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
