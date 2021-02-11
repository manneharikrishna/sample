class Regulation::NewLicenseForm < Regulation::LicenseForm
  property :lottery_type

  validates :lottery_type, inclusion: { in: Lottery::TYPES }
end
