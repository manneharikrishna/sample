class Admin::DrawingEntriesController < Admin::BaseController
  include PaginationHelper

  before_action :authorize_moderation

  def index
    entries = Admin::EntriesQuery.new(drawing, params).call
    meta = { total_pages: total_pages(entries) }

    render json: entries.includes(include), meta: meta, adapter: :json
  end

  def update
    entry.update!(status: status)
    render json: entry
  end

  private

  def authorize_moderation
    authorize(drawing, [:admin, :moderation])
  end

  def drawing
    @drawing ||= Drawing.find(params[:drawing_id])
  end

  def entry
    @entry ||= drawing.entries.find(params[:id])
  end

  def status
    @status ||= params.require(:status)
  end

  def include
    [:player, :photo, :winnings]
  end
end
