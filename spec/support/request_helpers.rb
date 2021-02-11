module RequestHelpers
  def basic_authorization_header(username, password)
    { HTTP_AUTHORIZATION: basic_authorization(username, password) }
  end

  def basic_authorization(username, password)
    ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
  end

  def authorization_header(user_type)
    { HTTP_AUTHORIZATION: "Token #{session_token(user_type)}" }
  end

  def session_token(user_type)
    user = public_send("current_#{user_type}")
    SessionToken.new(user).generate
  end

  def current_player
    @current_player ||= create_user(:player)
  end

  def current_operator
    @current_operator ||= create_user(:operator)
  end

  def current_regulator
    @current_regulator ||= create_user(:regulator)
  end

  def current_consultant
    @current_consultant ||= create_user(:consultant)
  end

  def create_user(user_type)
    create(user_type, password: 'password')
  end

  def json_response
    @json_response ||= JSON.parse(response.body)
  end
end
