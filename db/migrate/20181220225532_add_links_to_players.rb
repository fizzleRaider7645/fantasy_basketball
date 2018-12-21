class AddLinksToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :link, :string
  end
end
