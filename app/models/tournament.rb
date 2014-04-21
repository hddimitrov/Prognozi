class Tournament < ActiveRecord::Base
  attr_accessible :name, :start_at

  has_many :groups
  has_many :eliminations

  has_many :rooms

end
