class RemoveSalaryFromPlayers < ActiveRecord::Migration[5.2]
  def change
    remove_column :players, :salary, :float 
  end
end
