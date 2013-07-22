class Sport < ActiveRecord::Base
  attr_accessible :name

  has_many :tournaments, :teams
end
