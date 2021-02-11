class AddPlayerInfoToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :player_info, :json, default: {}
    
    Player.all.each do |player|
      player.player_info = { 'onboarding': false, 'won_prize': true, 'won_sc_ticket': true }
      player.player_info["onboarding"] = player.onboarding
      player.save
    end
  end
end
