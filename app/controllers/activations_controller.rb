class ActivationsController < BaseController
  skip_before_action :ensure_player_activated

  before_action :authorize_activation

  def create
    submit_form(ActivationForm.new(current_player))
  end

  private

  def authorize_activation
    authorize(:activation)
  end
end
