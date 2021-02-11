class Admin::FailedSessionAttemptsCounterSerializer < ActiveModel::Serializer
  attribute :today
  attribute :yesterday
  attribute :week
  attribute :last_week

  attribute :percentage_today
  attribute :all_today
  attribute :status
end
