class RoomsPublicRoomsFalseDefault < ActiveRecord::Migration
  def up
  	change_column :rooms, :public_room, :boolean, :default => false
  end

  def down
  end
end
