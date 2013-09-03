class Room < ActiveRecord::Base
  attr_accessible :name, :tournament_id, :user_id, :public_room

  has_many :invite_users
  has_many :user_rooms
  has_many :users, through: :user_rooms
  has_many :score_prediction_room_points
  belongs_to :tournament
end
