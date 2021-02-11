class PlayerDrawingsController < BaseController
  def index
    render json: drawings
  end

  def show
    drawing_summary = DrawingSummary.new(current_player, drawing)
    render json: drawing_summary
  end

  private

  def drawings
    @drawings ||= SummaryDrawingsQuery.new.call
  end

  def drawing
    @drawing ||= Drawing.find(params[:id])
  end
end
