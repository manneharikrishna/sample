class ProfilesController < BaseController
  def show
    render json: current_player
  end

  def update
    submit_form(PlayerForm.new(current_player), :ok)
  end
end
