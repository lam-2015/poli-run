# == Schema Information
#
# Table name: routes
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  departure     :string(255)
#  arrival       :string(255)
#  departure_lat :float
#  departure_lng :float
#  arrival_lat   :float
#  arrival_lng   :float
#  difficulty    :string(255)
#  distance      :float
#  time          :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Route < ActiveRecord::Base
  attr_accessible :departure, :arrival, :arrival_lat, :arrival_lng, :departure_lat, :departure_lng, :difficulty, :distance, :name, :time

  # link between addresses and their coordinates
  geocoded_by :departure, :latitude => :departure_lat, :longitude => :departure_lng
  geocoded_by :arrival, :latitude => :arrival_lat, :longitude => :arrival_lng

  # geocode!
  after_validation :geocode_both

  # each route belong to a specific user
  belongs_to :user

  # descending order for getting the routes
  default_scope order: 'routes.created_at DESC'

  # validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :departure, presence: true
  validates :arrival, presence: true


  private

  # geocode both the start and arrival addresses
  def geocode_both
    self.departure_lat, self.departure_lng = Geocoder.coordinates(self.departure)
    self.arrival_lat, self.arrival_lng = Geocoder.coordinates(self.arrival)
  end

end
