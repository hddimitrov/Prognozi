class User < ActiveRecord::Base
  attr_accessible :email, :name, :provider, :uid, :oauth_token, :oauth_expires_at

  has_many :user_rooms
  has_many :score_predictions
  has_many :user_bets

  def self.from_omniauth(auth)
    # user = User.find_or_create_by_provider_and_uid(auth.provider, auth.uid)
    # user.name = auth.info.name
    # user.oauth_token = auth.credentials.token
    # user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    # user.save!
    return user
  end

end
