class Team < ActiveRecord::Base
  belongs_to :user
  has_many :players

  def within_range?
    self.roster_spots.between?(0, 5)
  end
end
