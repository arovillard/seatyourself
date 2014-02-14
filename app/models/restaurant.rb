class Restaurant < ActiveRecord::Base
	has_many :reservations
  has_many :users, :through => :reservations
  belongs_to :user
  geocoded_by :address
  after_validation :geocode

  def opening_hour=(opening_hour)
    self[:opening_hour] = Time.new(2000,1,1, opening_hour.to_i)
  end

  def closing_hour=(closing_hour)
    self[:closing_hour] = Time.new(2000,1,1, closing_hour.to_i)
  end

end
