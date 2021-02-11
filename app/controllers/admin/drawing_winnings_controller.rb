class Admin::DrawingWinningsController < Admin::BaseController
  def index
    winnings = drawing.winnings.order(created_at: :desc)
    render json: winnings, include: include
  end

  private

  def drawing
    @drawing ||= Drawing.find(params[:drawing_id])
  end

  def include
    { ticket: { entry: [:player, :photo] } }
  end
end
