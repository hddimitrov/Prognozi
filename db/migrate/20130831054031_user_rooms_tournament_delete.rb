class UserRoomsTournamentDelete < ActiveRecord::Migration
  def up
  	remove_column :user_rooms, :tournament_id
  end

  def down
  end
end
