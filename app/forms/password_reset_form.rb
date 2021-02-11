class PasswordResetForm < Reform::Form
  property :email, virtual: true
  property :redirect_url, virtual: true

  validates :email, email: true
  validates :redirect_url, url: true, allowed_host: true

  def save
    SendPasswordResetEmail.new(user_type, email, redirect_url).call
  end

  private

  def user_type
    @user_type ||= model.class.name.underscore
  end
end
