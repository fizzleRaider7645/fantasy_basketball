class RemoveLinksFromPlayers < ActiveRecord::Migration[5.2]
  def change
    remove_column :players, :link, :string 
  end
end
