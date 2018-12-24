class User < ActiveRecord::Base
  has_secure_password
  has_one :team
  validates_presence_of :username, :email, :password_digest
  include Slugifiable::Instance
  extend Slugifiable::Class
end
