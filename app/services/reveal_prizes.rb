class RevealPrizes
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    drawing.entries.find_each do |entry|
      prizes = unrevealed_weekly_prizes(entry)

      if prizes.present?
        create_awards(entry, prizes)
        send_prize_reveal_email(entry, prizes)
      end

      reveal_tickets(not_revealed_tickets(entry))
    end
  end

  private

  attr_reader :drawing

  def unrevealed_weekly_prizes(entry)
    entry.prizes.weekly.where(tickets: { revealed_at: nil })
  end

  def create_awards(entry, prizes)
    prizes.each do |prize|
      create_award(entry, prize) unless prize.physical?
    end
  end

  def create_award(entry, prize)
    CreateAward.new(entry, prize).call
  end

  def send_prize_reveal_email(entry, prizes)
    PrizeMailer.prize_reveal(entry, prizes.to_a).deliver_later(wait: 10.minutes)
  end

  def reveal_tickets(not_revealed_tickets)
    not_revealed_tickets.each do |ticket|
      ticket.ticket_autoreveals.create(ticket_type: :weekly)
    end

    not_revealed_tickets.reveal_all
  end

  def not_revealed_tickets(entry)
    entry.tickets.not_revealed
  end
end
