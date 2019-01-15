class ReaddScrapedToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :scraped?, :boolean, null: false, default: false
  end
end
