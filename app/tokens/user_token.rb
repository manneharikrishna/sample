class UserToken < ApplicationToken
  def initialize(user)
    @user = user
  end

  private

  def payload
    super.merge("#{user_type}_id" => @user.id, email: @user.email)
  end

  def user_type
    @user.class.name.underscore
  end
end
