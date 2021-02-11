class ActivationForm < Reform::Form
  LANGUAGES = I18n.available_locales.map(&:to_s).freeze

  property :first_name
  property :last_name
  property :email
  property :password
  property :language
  property :is_pep

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :unified_email, email: true
  validates :password, length: { minimum: 8 }
  validates :language, inclusion: { in: LANGUAGES }, allow_nil: true

  validates_uniqueness_of :email

  def save
    if super
      activate_player
      schedule_profile_change_tracking
    end
  end

  def unified_email
    @fields['email'] = email&.downcase&.gsub(/\s+/, '')
  end

  private

  def activate_player
    ActivatePlayer.new(model).call
  end

  def schedule_profile_change_tracking
    TrackProfileChangeJob.perform_later(model)
  end
end
