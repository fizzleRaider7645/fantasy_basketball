class RemoveScrapedFromPlayers < ActiveRecord::Migration[5.2]
  def change
    remove_column :players, :scraped?, :boolean
  end
end
