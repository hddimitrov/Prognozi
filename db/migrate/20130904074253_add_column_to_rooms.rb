class AddColumnToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :public_room, :boolean
  end
end
