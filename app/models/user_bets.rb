class UserBets < ActiveRecord::Base
  attr_accessible :bet_id, :points, :user_id

  belongs_to :user
end
