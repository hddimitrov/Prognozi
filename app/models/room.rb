class Room < ActiveRecord::Base
  attr_accessible :name, :tournament_id

  has_many :user_rooms
  belongs_to :tournament
end
