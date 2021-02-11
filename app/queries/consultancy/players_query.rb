class Consultancy::PlayersQuery < ApplicationQuery
  def initialize(params)
    @params = params
  end

  def call
    find_player_by_email.or(find_player_by_first_name.or(find_player_by_last_name))
  end

  private

  def find_player_by_last_name
    players.where('last_name ILIKE ?', search)
  end

  def find_player_by_first_name
    players.where('first_name ILIKE ?', search)
  end

  def find_player_by_email
    players.where('email ILIKE ?', search)
  end

  def players
    @players ||= Player.all
  end

  def search
    @search ||= "%#{@params}%"
  end
end
