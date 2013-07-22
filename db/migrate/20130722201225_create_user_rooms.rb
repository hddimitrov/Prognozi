class CreateUserRooms < ActiveRecord::Migration
  def change
    create_table :user_rooms do |t|
      t.integer :room_id
      t.integer :user_id
      t.integer :tournament_id

      t.timestamps
    end
  end
end
