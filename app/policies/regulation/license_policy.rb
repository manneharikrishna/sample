Regulation::LicensePolicy = Struct.new(:regulator, :license) do
  def update?
    lotteries_not_present?
  end

  def destroy?
    lotteries_not_present?
  end

  private

  def lotteries_not_present?
    license.lotteries.empty?
  end
end
