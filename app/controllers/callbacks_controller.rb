class CallbacksController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :authorize_request

  def create
    suppress(ResponseError) do
      VerifyTransaction.new(deposit).call if deposit.present?
    end

    head :ok
  end

  private

  def authorize_request
    authenticate_or_request_with_http_basic do |username, password|
      nets_username = ENV['NETS_CALLBACK_USERNAME']
      nets_password = ENV['NETS_CALLBACK_PASSWORD']

      username == nets_username && password == nets_password
    end
  end

  def deposit
    @deposit ||= DepositQuery.new(nets_payment_id).call
  end

  def nets_payment_id
    params['TransactionId']
  end
end
