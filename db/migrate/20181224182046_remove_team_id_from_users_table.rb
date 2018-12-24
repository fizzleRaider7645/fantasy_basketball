class RemoveTeamIdFromUsersTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :team_id, :integer 
  end
end
