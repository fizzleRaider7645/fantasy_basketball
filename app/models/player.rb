class Player < ActiveRecord::Base
  belongs_to :team
  include Slugifiable::Instance
  extend Slugifiable::Class
end
