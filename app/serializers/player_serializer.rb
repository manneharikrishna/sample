class PlayerSerializer < ActiveModel::Serializer
  attribute :first_name
  attribute :last_name
  attribute :birthdate
  attribute :email
  attribute :phone_number
  attribute :bank_account_number
  attribute :suspended_until
  attribute :weekly_loss_limit
  attribute :daily_loss_limit
  attribute :language
  attribute :is_activated
  attribute :onboarding
  attribute :information
  attribute :player_info

  has_one :avatar

  def is_activated
    object.activated?
  end

  def avatar
    Avatar.new(object)
  end
end
