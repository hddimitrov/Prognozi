class Tournament < ActiveRecord::Base
  attr_accessible :name, :start_at

  has_many :groups
  has_many :eliminations

  has_many :rooms
  has_many :teams
  has_many :top_scorer_predictions

end
