class UserRoom < ActiveRecord::Base
  attr_accessible :room_id, :tournament_id, :user_id

  belongs_to :room
  belongs_to :user
end
