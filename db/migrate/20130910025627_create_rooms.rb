class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :tournament_id
      t.integer :creator_id
      t.boolean :q_public, default: false

      t.timestamps
    end
  end
end
