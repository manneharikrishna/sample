class TrackWalletBalance
  def initialize(player, balance)
    @player = player
    @balance = balance
  end

  def call
    RegisterInAnalytics.new(player, :set, payload).call
  end

  private

  attr_reader :player

  def payload
    {
      'Wallet Balance' => @balance.to_f
    }
  end
end
