class Team < ActiveRecord::Base
  belongs_to :user
  has_many :players

  def below_max?
    self.players.length < 5
  end
end
