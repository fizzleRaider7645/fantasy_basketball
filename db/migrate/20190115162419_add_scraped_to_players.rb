class AddScrapedToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :scraped?, :boolean
  end
end
