class AddOnboardingToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :onboarding, :boolean, default: false
  end
end
