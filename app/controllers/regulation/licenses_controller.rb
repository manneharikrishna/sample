class Regulation::LicensesController < Regulation::BaseController
  before_action :authorize_license, only: [:update, :destroy]

  def index
    render json: License.all
  end

  def create
    submit_form(Regulation::NewLicenseForm.new(License.new))
  end

  def update
    submit_form(Regulation::LicenseForm.new(license), :ok)
  end

  def destroy
    license.destroy!
    head :ok
  end

  private

  def authorize_license
    authorize(license, [:regulation, :license])
  end

  def license
    @license ||= License.find(params[:id])
  end
end
