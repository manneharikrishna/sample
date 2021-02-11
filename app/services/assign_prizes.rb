class AssignPrizes
  def initialize(drawing)
    @drawing = drawing
    @remaining_tickets = drawing.tickets.pluck(:id)
  end

  def call
    @drawing.prizes.each { |p| assign_prize(p) }
    non_wininng_ticket
  end

  private

  attr_reader :drawing
  attr_reader :remaining_tickets

  def assign_prize(prize)
    tickets = random_tickets(prize.quantity)
    set_prize(tickets, prize)
    remove_tickets(tickets)
  end

  def random_tickets(count)
    remaining_tickets.sample(count, random: RNG)
  end

  def remove_tickets(tickets)
    @remaining_tickets -= tickets
  end

  def set_prize(tickets, prize)
    drawing.tickets.where(id: tickets).update_all(prize_id: prize.id)
    set_tile(tickets)
  end

  def set_tile(tickets)
    tickets.each do |ticket_id|
      ticket = Ticket.find(ticket_id.to_i)
      ticket.non_win_scratch_state(ticket.win_prize(ticket.prize.value.to_i))
      ticket.save
    end
  end

  def non_wininng_ticket
    @remaining_tickets.each do |ticket_id|
      ticket = Ticket.find(ticket_id.to_i)
      ticket.non_win_scratch_state(ticket.non_win_prize)
      ticket.save
    end
  end
end
