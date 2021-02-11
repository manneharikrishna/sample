class EntriesController < BaseController
  include PaginationHelper

  def index
    entries = EntriesQuery.new(current_player, params).call
    meta = { total_pages: total_pages(entries) }

    render json: entries.includes(include), meta: meta, adapter: :json, include: include
  end

  def show
    render json: entry, include: include
  end

  private

  def entry
    @entry ||= current_player.entries.find(params[:id])
  end

  def include
    [:photo, :payment, { drawing: :prizes, tickets: :prize }]
  end
end
