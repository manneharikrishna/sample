class Deposits::Create
  def initialize(player, payload_configurator)
    @player = player
    @payload_configurator = payload_configurator
  end

  def call
    create_deposit.tap do |deposit|
      nets_payment = register_nets_payment(deposit)
      save_transaction_data(deposit, nets_payment)
    end
  end

  private

  attr_reader :player

  def create_deposit
    player.deposits.create!(amount: amount)
  end

  def amount
    @payload_configurator.amount / 100
  end

  def register_nets_payment(deposit)
    Nets::RegisterPayment.new(@payload_configurator.call(deposit)).call
  end

  def save_transaction_data(deposit, nets_payment)
    deposit.update!(nets_payment_id: nets_payment.id)
    deposit.update!(redirect_url: nets_payment.redirect_url)
  end
end
