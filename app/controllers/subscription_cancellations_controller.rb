class SubscriptionCancellationsController < BaseController
  def create
    CancelSubscription.new(current_player).call
    head :created
  end
end
