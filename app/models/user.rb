class User < ActiveRecord::Base
  attr_accessible :email, :name

  has_many :user_rooms, :score_predictions, :user_bets
end
