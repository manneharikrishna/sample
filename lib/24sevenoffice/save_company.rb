class TwentyFourSevenOffice::SaveCompany
  def initialize(company)
    @company = company
  end

  def call
    response = client.call(:save_companies, message: message, cookies: session)

    if response.success?
      company_id(response.body)
    else
      raise TwentyFourSevenOffice::Error, response
    end
  end

  private

  def client
    @client ||= Savon.client(wsdl: TwentyFourSevenOffice::Config::COMPANY_SERVICE_WSDL)
  end

  def message
    { 'companies' => [@company.to_hash] }
  end

  def session
    @session ||= TwentyFourSevenOffice::CreateSession.new.call
  end

  def company_id(response)
    response.dig(:save_companies_response, :save_companies_result, :company, :id)
  end
end
