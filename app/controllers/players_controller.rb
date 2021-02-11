class PlayersController < BaseController
  skip_before_action :authorize_request
  skip_before_action :ensure_player_activated

  before_action :reactivate_player, if: -> { player.deactivated? }

  def create
    return render_session if player.persisted?

    form = NewPlayerForm.new(player)

    if form.validate(player_params)
      form.save
      render_session
    else
      render_errors(form)
    end
  end

  private

  def reactivate_player
    player.update!(deactivated_at: nil)
  end

  def render_session
    render json: Session.new(player), status: :created
  end

  def player_params
    {
      first_name: bankid_user.given_name,
      last_name: bankid_user.family_name,
      phone_number: bankid_user.phone_number,
      birthdate: bankid_user.birthdate,
      ssn: bankid_user.ssn
    }
  end

  def player
    @player ||= Player.find_or_initialize_by(ssn: bankid_user.ssn)
  end

  def bankid_user
    @bankid_user ||= BankID::Token.new(bankid_code).call
  end

  def bankid_code
    @bankid_code ||= params.require(:bankid_code)
  end
end
