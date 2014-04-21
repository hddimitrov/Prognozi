class PredictionPoint < ActiveRecord::Base
  attr_accessible :points, :prediction_id, :prediction_type, :room_id, :user_id

  belongs_to :user
  belongs_to :room
  belongs_to :prediction, polymorphic: true

  after_save :update_room_points
  after_destroy :update_room_points

  def update_room_points
    ur = UserRoom.find_by_user_id_and_room_id(self.user_id, self.room_id)
    ur.update_column(:points, PredictionPoint.where(user_id: self.user_id, room_id: self.room_id).sum(:points))
  end
end
