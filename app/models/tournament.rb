class Tournament < ActiveRecord::Base
  attr_accessible :name, :sport_id

  belongs_to :sport
end
