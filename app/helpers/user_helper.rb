module UserHelper
  def user
    @user ||= user_class.find_by(email: @email)
  end

  def user_class
    @user_type.to_s.classify.constantize
  end
end
