class Regulation::DrawingsController < Regulation::BaseController
  def show
    render json: drawing
  end

  private

  def drawing
    @drawing ||= Drawing.find(params[:id])
  end
end
