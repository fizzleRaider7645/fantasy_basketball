class AddTeamIdToUserTable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :team_id, :integer
  end
end
