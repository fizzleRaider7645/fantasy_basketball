class Team < ActiveRecord::Base
  belongs_to :user
  has_many :players

  def at_limit?
    self.players.count == 5
  end
end
