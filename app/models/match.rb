class Match < ActiveRecord::Base
  attr_accessible :guest, :guest_score, :host, :host_score, :level, :timestamp, :tournament_id
  attr_accessor:name
  belongs_to :tournament
  def name
    name = host + "-" + guest
  end
end
