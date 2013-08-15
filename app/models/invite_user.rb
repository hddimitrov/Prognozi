class InviteUser < ActiveRecord::Base
  attr_accessible :room_id, :user_id, :uid, :status

  belongs_to :room
  belongs_to :user
end
