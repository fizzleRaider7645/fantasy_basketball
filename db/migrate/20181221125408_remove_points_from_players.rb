class RemovePointsFromPlayers < ActiveRecord::Migration[5.2]
  def change
    remove_column :players, :points, :float 
  end
end
