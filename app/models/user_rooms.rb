class UserRooms < ActiveRecord::Base
  attr_accessible :room_id, :tournament_id, :user_id

  belongs_to :room, :user
end
