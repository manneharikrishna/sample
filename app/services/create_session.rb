class CreateSession
  include UserHelper

  def initialize(user_type, email, password)
    @user_type = user_type
    @email = email
    @password = password
  end

  def call
    if authenticated?
      schedule_sign_in_tracking
      increase_success_session_counter
      generate_session
    else
      increase_failed_session_counter
      raise_error
    end
  end

  private

  attr_reader :password

  def authenticated?
    user&.active? && password_valid?
  end

  def password_valid?
    user.authenticate(password)
  end

  def schedule_sign_in_tracking
    TrackSignInJob.perform_later(user)
  end

  def increase_success_session_counter
    IncreaseSuccessSessionCounter.new.call
  end

  def generate_session
    Session.new(user)
  end

  def increase_failed_session_counter
    IncreaseFailedSessionCounter.new.call
  end

  def raise_error
    raise ResponseError.new(:forbidden, :invalid_credentials)
  end
end
