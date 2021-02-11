class PlayerForm < Reform::Form
  include Reform::Form::Coercion

  LANGUAGES = I18n.available_locales.map(&:to_s).freeze

  property :first_name
  property :last_name
  property :phone_number
  property :bank_account_number
  property :language
  property :avatar
  property :player_info

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, phony_plausible: { normalized_country_code: COUNTRY_CODE }
  validates :bank_account_number, bank_account_number: true,
    bank_account_ownership: { if: :norway? }, allow_blank: true
  validates :language, inclusion: { in: LANGUAGES }, allow_blank: true
  validate :set_player_info, if: :validate_layer_info?

  def save
    if super
      schedule_registration_in_accounting
      schedule_profile_change_tracking
    end
  end

  def set_player_info
    player_info_keys = player_info.keys
      model.player_info.each do |key,_|
        player_info[key] = model.player_info[key] unless player_info_keys.include?(key)
      end
    return player_info
  end

  def validate_layer_info?
    unless player_info == model.player_info
      player_info.each do |key,_|
        unless player_info[key] == true or player_info[key] == false
          errors.add(:base, 'send proper value')
          return false
        else
          if model.player_info[key] == true and player_info[key] == false
            errors.add(:base, 'already value updated to true')
            return false
          end
        end
      end
    end
  end
  private

  def norway?
    ENV['COUNTRY_CODE'] == 'NO'
  end

  def schedule_registration_in_accounting
    RegisterPlayerInAccountingJob.perform_later(model)
  end

  def schedule_profile_change_tracking
    TrackProfileChangeJob.perform_later(model)
  end
end
