class ChangePassword
  def initialize(user, password, new_password)
    @user = user
    @password = password
    @new_password = new_password
  end

  def call
    change_password if password_valid?
  end

  private

  attr_reader :user
  attr_reader :password
  attr_reader :new_password

  def password_valid?
    user.authenticate(password)
  end

  def change_password
    user.update!(password: new_password)
  end
end
