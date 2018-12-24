class Team < ActiveRecord::Base
  belongs_to :user
  has_many :players
  include Slugifiable::Instance
  extend Slugifiable::Class
end
