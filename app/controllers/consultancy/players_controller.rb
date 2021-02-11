class Consultancy::PlayersController < Consultancy::BaseController
  def index
    players = Consultancy::PlayersQuery.new(params[:search]).call
    render json: players
  end

  def show
    render json: player, serializer: Consultancy::PlayerDetailsSerializer
  end

  private

  def player
    @player ||= Player.find(params[:id])
  end
end
