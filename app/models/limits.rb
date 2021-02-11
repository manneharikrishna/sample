class Limits
  include ActiveModel::Serialization

  delegate :balance_limit, to: self
  delegate :transfer_limit, to: self
  delegate :weekly_loss_limit, to: self
  delegate :daily_loss_limit, to: self

  def self.balance_limit
    ENV.fetch('BALANCE_LIMIT').to_d
  end

  def self.transfer_limit
    ENV.fetch('TRANSFER_LIMIT').to_d
  end

  def self.weekly_loss_limit
    ENV.fetch('WEEKLY_LOSS_LIMIT').to_d
  end

  def self.daily_loss_limit
    ENV.fetch('DAILY_LOSS_LIMIT').to_d
  end
end
