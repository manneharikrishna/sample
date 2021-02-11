class LimitsSerializer < ActiveModel::Serializer
  attribute :balance_limit
  attribute :transfer_limit
  attribute :weekly_loss_limit
  attribute :daily_loss_limit
end
