class CreateSubscription
  def initialize(player, params)
    @player = player
    @params = params
  end

  def call
    create_subscription.tap do
      create_deposit
      set_redirect_url
      assigns_subscription_deposit
    end
  end

  private

  attr_reader :player
  attr_reader :params
  attr_reader :subscription
  attr_reader :deposit

  def create_subscription
    @subscription ||= player.subscriptions.create!(
      tickets_count: params[:tickets_count],
      photo_id: photo.id
    )
  end

  def photo
    photos.find_by!(id: params[:photo_id])
  end

  def photos
    Photo.where(player: [nil, player])
  end

  def create_deposit
    @deposit ||= Deposits::Create.new(player, subscription_payload).call
  end

  def subscription_payload
    Deposits::ConfigureSubscriptionPayload.new(player, params)
  end

  def set_redirect_url
    subscription.redirect_url = deposit.redirect_url
  end

  def assigns_subscription_deposit
    deposit.update!(subscription_id: subscription.id)
  end
end
