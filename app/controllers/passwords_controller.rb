class PasswordsController < BaseController
  def update
    if ChangePassword.new(current_player, password, new_password).call
      head :ok
    else
      head :forbidden
    end
  end

  private

  def password
    @password ||= params.require(:password)
  end

  def new_password
    @new_password ||= params.require(:new_password)
  end
end
