class Player < ApplicationRecord
  has_many :photos

  has_many :entries
  has_many :tickets, through: :entries

  has_many :transactions
  has_many :deposits
  has_many :payments
  has_many :awards
  has_many :subscriptions

  has_secure_password validations: false

  has_event :activate
  has_event :deactivate

  phony_normalize :phone_number, default_country_code: COUNTRY_CODE

  mount_uploader :avatar, AvatarUploader

  before_save :strip_bank_account_number
  before_create :set_player_info

  validates :password, length: { minimum: 8 }, allow_nil: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def suspended?
    return false if suspended_until.nil?
    suspended_until.future?
  end

  def active?
    activated? && !deactivated?
  end

  private

  def strip_bank_account_number
    bank_account_number&.gsub!(/\s+/, '')
  end

  def set_player_info
    self.player_info = { 'onboarding': false, 'won_prize': false, 'won_sc_ticket': false }
  end
end
