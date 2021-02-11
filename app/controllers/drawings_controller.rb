class DrawingsController < BaseController
  skip_before_action :authorize_request
  skip_before_action :ensure_player_activated

  def index
    drawings = DrawingsQuery.new.call
    render json: drawings, include: :prizes
  end
end
