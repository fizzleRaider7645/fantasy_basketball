class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :team_id
      t.float :salary
      t.float :points
    end
  end
end
