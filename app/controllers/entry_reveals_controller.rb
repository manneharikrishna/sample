class EntryRevealsController < BaseController
  before_action :ensure_entry_unrevealed

  def create
    RevealEntry.new(entry).call
    render json: entry, status: :created
  end

  private

  def ensure_entry_unrevealed
    raise ResponseError.new(:forbidden, :entry_revealed) if entry.revealed?
  end

  def entry
    @entry ||= current_player.entries.find(params[:entry_id])
  end
end
