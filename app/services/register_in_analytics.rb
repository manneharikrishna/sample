class RegisterInAnalytics
  MIXPANEL_METHODS = [:set, :increment].freeze

  def initialize(player, method, payload)
    @distinct_id = player.id
    @method = method
    @payload = payload
  end

  def call
    raise 'Method not allowed' if method_invalid?

    unless register_in_mixpanel
      raise 'Registration in Mixpanel failed'
    end
  end

  private

  attr_reader :method
  attr_reader :distinct_id
  attr_reader :payload

  def method_invalid?
    !MIXPANEL_METHODS.include?(method)
  end

  def register_in_mixpanel
    mixpanel_client.people.send(method, distinct_id, payload)
  end

  def mixpanel_client
    Mixpanel::Tracker.new(ENV['MIXPANEL_TOKEN'])
  end
end
