class User < ActiveRecord::Base
  attr_accessible :email, :name, :provider, :uid, :oauth_token, :oauth_expires_at

  has_many :user_rooms
  has_many :score_predictions
  has_many :user_bets

end
