class Team < ActiveRecord::Base
  belongs_to :user
  has_many :players

  def at_max?
    self.roster_spots == 5
  end

  def at_min?
    self.roster_spots == 0
  end
end
