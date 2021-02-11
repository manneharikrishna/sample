class ResetPassword
  def initialize(user_type, token, new_password)
    @user_type = user_type
    @token = token
    @new_password = new_password
  end

  def call
    if user.present?
      reset_password
      user
    else
      raise_error
    end
  end

  private

  attr_reader :user_type
  attr_reader :token
  attr_reader :new_password

  def user
    @user ||= VerifyToken.new(token, user_type, :password_reset).call
  end

  def reset_password
    user.update(password: new_password)
  end

  def raise_error
    raise ResponseError, :forbidden
  end
end
