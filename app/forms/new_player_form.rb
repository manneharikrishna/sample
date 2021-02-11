class NewPlayerForm < Reform::Form
  property :first_name
  property :last_name
  property :birthdate
  property :ssn
  property :phone_number

  validates :birthdate, presence: true,
    timeliness: { on_or_before: -> { 18.years.ago }, type: :date }
  validates :ssn, presence: true
  validates :phone_number, phony_plausible: { normalized_country_code: COUNTRY_CODE }

  validates_uniqueness_of :ssn

  def save
    set_onboarding if super
  end

  private

  def set_onboarding
    unless model.active?
      model.update!(onboarding: true, information: false)
    end
  end
end
