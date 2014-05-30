class Group < ActiveRecord::Base
  attr_accessible :name, :tournament_id

  belongs_to :tournament
  has_many :group_standings
  has_many :group_standing_predictions

  has_many :matches, as: :phase
end
