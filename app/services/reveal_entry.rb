class RevealEntry
  def initialize(entry, ticket_type = nil)
    @entry = entry
    @ticket_type = ticket_type
  end

  def call
    prizes = entry.prizes.instant

    if prizes.present?
      create_awards(prizes)
      send_prize_reveal_email(prizes)
    end

    entry.reveal
    reveal_tickets(tickets_with_instant_prizes)
  end

  private

  attr_reader :entry
  attr_reader :ticket_type

  def create_awards(prizes)
    prizes.each do |prize|
      create_award(prize) unless prize.physical?
    end
  end

  def create_award(prize)
    CreateAward.new(entry, prize).call
  end

  def send_prize_reveal_email(prizes)
    PrizeMailer.prize_reveal(entry, prizes.to_a).deliver_later(wait: 10.minutes)
  end

  def tickets_with_instant_prizes
    @tickets_with_instant_prizes ||=
      entry.tickets.joins(:prize).where(prizes: { reveal_type: :instant })
  end

  def reveal_tickets(tickets_with_instant_prizes)
    update_ticket_autoreveals if ticket_type.present?
    tickets_with_instant_prizes.reveal_all
  end

  def update_ticket_autoreveals
    entry.tickets.each do |ticket|
      ticket.ticket_autoreveals.create(ticket_type: @ticket_type)
    end
  end
end
