class User < ActiveRecord::Base
  has_secure_password
  has_one :team
  include Slugifiable::Instance
  extend Slugifiable::Class
end
