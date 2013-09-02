class AddColumnToUserRooms < ActiveRecord::Migration
  def change
  	add_column :user_rooms, :uid, :integer
  end
end
