class OnboardsController < BaseController
  def update
    current_player.update!(onboarding: false, information: false)
    render json: current_player
  end
end
