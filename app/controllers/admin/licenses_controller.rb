class Admin::LicensesController < Admin::BaseController
  def index
    render json: License.all
  end
end
