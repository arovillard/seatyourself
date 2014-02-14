class User < ActiveRecord::Base
  has_secure_password
  has_one :restaurant
  has_many :reservations
  has_many :restaurants, :through => :reservations
end