class TicketRevealsController < BaseController
  before_action :authorize_ticket_reveal

  def create
    RevealTicket.new(ticket).call
    render json: ticket, status: :created
  end

  private

  def authorize_ticket_reveal
    authorize(ticket, :ticket_reveal)
  end

  def ticket
    @ticket ||= current_player.tickets.find(params[:ticket_id])
  end
end
