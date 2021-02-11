class TicketsController < BaseController
  before_action :ensure_player_not_suspended

  def show
    render json: ticket, include: include
  end

  def update
    submit_form(TicketForm.new(ticket), :ok)
  end

  private

  def ticket
    @ticket ||= entry.tickets.find(params[:id])
  end

  def entry
    @entry ||= current_player.entries.find(params[:entry_id])
  end

  def include
    [:prize, :drawing]
  end
end
