class Matches < ActiveRecord::Base
  attr_accessible :guest, :guest_score, :host, :host_score, :level, :timestamp, :tournament_id

  belongs_to :tournament
end
