class Admin::DrawingStatisticsController < Admin::BaseController
  before_action :authorize_statistics

  def show
    drawing_statistics = DrawingStatistics.new(drawing)
    render json: drawing_statistics, include: include
  end

  private

  def authorize_statistics
    authorize(drawing, [:admin, :statistics])
  end

  def drawing
    @drawing ||= Drawing.find(params[:drawing_id])
  end

  def include
    [:revenue, :tickets, :spending, payout: :prizes]
  end
end
