class DrawingTicketsController < BaseController
  before_action :ensure_player_not_suspended

  def index
    tickets = DrawingTicketsQuery.new(current_player, drawing).call
    render json: tickets.includes(entry: :photo)
  end

  private

  def drawing
    @drawing ||= Drawing.find(params[:drawing_id])
  end
end
