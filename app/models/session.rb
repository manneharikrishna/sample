class Session
  include ActiveModel::Serialization

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def token
    SessionToken.new(@user).generate
  end

  def currency
    CURRENCY
  end

  def limits
    Limits.new
  end
end
