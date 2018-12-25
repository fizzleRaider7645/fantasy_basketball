class Team < ActiveRecord::Base
  belongs_to :user
  has_many :players

  def current_roster_count
    self.roster_spots - self.players.count
  end
end
