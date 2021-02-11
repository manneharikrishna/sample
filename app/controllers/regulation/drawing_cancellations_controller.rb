class Regulation::DrawingCancellationsController < Regulation::BaseController
  before_action :authorize_cancellation

  def create
    CancelDrawing.new(drawing).call
    render json: drawing, status: :created
  end

  private

  def authorize_cancellation
    authorize(drawing, [:regulation, :drawing_cancellation])
  end

  def drawing
    @drawing ||= Drawing.find(params[:drawing_id])
  end
end
