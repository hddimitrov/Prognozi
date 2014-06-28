class Elimination < ActiveRecord::Base
  attr_accessible :name, :tournament_id, :code

  belongs_to :tournament
  has_many :elimination_phases
  has_many :matches, as: :phase
end
