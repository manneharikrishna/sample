class Admin::FailedSessionAttemptsController < Admin::BaseController
  def index
    render json: FailedSessionAttemptsCounter.new
  end
end
