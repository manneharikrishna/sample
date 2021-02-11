class TwentyFourSevenOffice::SaveBundleList
  def initialize(message)
    @message = message
  end

  def call
    response = client.call(:save_bundle_list, message: message, cookies: session)

    if response.success?
      true
    else
      raise TwentyFourSevenOffice::Error, response
    end
  end

  private

  attr_reader :message

  def client
    @client ||= Savon.client(wsdl: TwentyFourSevenOffice::Config::ACCOUNT_SERVICE_WSDL)
  end

  def session
    @session ||= TwentyFourSevenOffice::CreateSession.new.call
  end
end
