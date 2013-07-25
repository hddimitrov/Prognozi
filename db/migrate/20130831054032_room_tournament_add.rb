class RoomTournamentAdd < ActiveRecord::Migration
  def up
  	add_column :rooms, :tournament_id, :integer
  end

  def down
  	remove_column :rooms, :tournament_id
  end
end
