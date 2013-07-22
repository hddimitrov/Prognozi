class Room < ActiveRecord::Base
  attr_accessible :name

  has_many :user_rooms
end
