class DrawingEntriesController < BaseController
  before_action :ensure_player_not_suspended
  before_action :authorize_entry

  def create
    entry = CreateEntry.new(drawing, current_player, params).call
    render json: entry, include: include, status: :created
  end

  private

  def drawing
    @drawing ||= Drawing.find(params[:drawing_id])
  end

  def include
    [:photo, :payment, { tickets: :prize }]
  end
end
