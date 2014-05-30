class Room < ActiveRecord::Base
  attr_accessible :name, :tournament_id, :creator_id, :q_public

  belongs_to :tournament

  has_many :user_rooms
  has_many :users, through: :user_rooms

  # has_many :invitations
end
