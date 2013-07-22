class Group < ActiveRecord::Base
  attr_accessible :name

  has_many :team_groups
end
