class ChangeOwnerIdToUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :teams, :owner_id, :user_id, :integer
  end
end
