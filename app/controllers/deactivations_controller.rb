class DeactivationsController < BaseController
  def create
    DeactivatePlayer.new(current_player).call
    head :ok
  end
end
