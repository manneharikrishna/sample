class TwentyFourSevenOffice::CreateSession
  def call
    response = client.call(:login, message: message)

    if response.success?
      response.http.cookies
    else
      raise TwentyFourSevenOffice::Error, response
    end
  end

  private

  def client
    @client ||= Savon.client(wsdl: TwentyFourSevenOffice::Config::AUTHENTICATE_WSDL)
  end

  def message
    {
      'credential' => {
        'ApplicationId' => TwentyFourSevenOffice.config.application_id,
        'IdentityId' => TwentyFourSevenOffice.config.identity_id,
        'Username' => TwentyFourSevenOffice.config.username,
        'Password' => TwentyFourSevenOffice.config.password
      }
    }
  end
end
