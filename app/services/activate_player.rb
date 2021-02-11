class ActivatePlayer
  def initialize(player)
    @player = player
  end

  def call
    player.transaction do
      activate_player
      send_welcome_email
      schedule_registration_in_accounting
    end
  end

  private

  attr_reader :player

  def activate_player
    player.activate
  end

  def send_welcome_email
    SignUpMailer.welcome(player).deliver_later
  end

  def schedule_registration_in_accounting
    RegisterPlayerInAccountingJob.perform_later(player)
  end
end
