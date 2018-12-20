class AddSalaryCapToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :salary_cap, :float
  end
end
