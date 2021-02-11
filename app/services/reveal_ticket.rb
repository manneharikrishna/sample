class RevealTicket
  delegate :prize, to: :@ticket
  delegate :entry, to: :@ticket

  def initialize(ticket)
    @ticket = ticket
  end

  def call
    if prize.present?
      create_award unless prize.physical?
      send_prize_reveal_email
    end

    reveal_ticket
  end

  private

  attr_reader :ticket

  def create_award
    CreateAward.new(entry, prize).call
  end

  def send_prize_reveal_email
    PrizeMailer.prize_reveal(entry, [prize]).deliver_later(wait: 10.minutes)
  end

  def reveal_ticket
    ticket.reveal
  end
end
