class EndDrawing
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    update_drawing_status

    if predrawn_lottery?
      reveal_entries
      send_weekly_reminder_emails
    else
      create_winning
    end

    repeat_drawing unless lottery_ending?
  end

  private

  attr_reader :drawing

  def update_drawing_status
    drawing.state_machine.transition_to!(:ended)
  end

  def predrawn_lottery?
    drawing.lottery.type == 'predrawn'
  end

  def send_weekly_reminder_emails
    players_with_weekly_prizes.each do |player|
      PrizeMailer.weekly_reminder(
        player,
        player['golden_tickets'],
        drawing,
        weekly_lottery_url
      ).deliver_later
    end
  end

  def players_with_weekly_prizes
    PlayersGoldenTicketsQuery.new(drawing).call
  end

  def reveal_entries
    RevealEntries.new(drawing).call
  end

  def create_winning
    CreateWinning.new(drawing).call
  end

  def repeat_drawing
    RepeatDrawing.new(drawing.lottery).call
  end

  def lottery_ending?
    next_drawing_end_time > lottery_end
  end

  def next_drawing_end_time
    drawing.ends_at + drawing.lottery.repeat_every.seconds
  end

  def lottery_end
    drawing.lottery.ends_at
  end

  def weekly_lottery_url
    @weekly_lottery_url ||= GenerateWeeklyLotteryUrl.new(drawing).call
  end
end
