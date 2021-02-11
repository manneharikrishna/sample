class SubscriptionEntriesController < BaseController
  def index
    entries = SubscriptionEntriesQuery.new(current_player, drawing).call
    render json: entries
  end

  private

  def drawing
    @drawing ||= Drawing.find(params[:drawing_id])
  end
end
