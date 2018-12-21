class RemoveSalaryCapFromTeams < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams, :salary_cap, :float 
  end
end
