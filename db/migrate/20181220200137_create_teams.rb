class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :owner_id
      t.integer :roster_spots
    end
  end
end
