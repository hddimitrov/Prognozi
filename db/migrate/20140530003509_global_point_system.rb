class GlobalPointSystem < ActiveRecord::Migration
  def up
    remove_column :prediction_points, :room_id
    remove_column :user_rooms, :points

    add_column :users, :group_phase_points, :float, default: 0
    add_column :users, :elimination_phase_points, :float, default: 0
  end

  def down
    add_column :prediction_points, :room_id, :integer
    add_index :prediction_points, [:user_id, :room_id]

    add_column :user_rooms, :points, :float, default: 0

    remove_column :users, :group_phase_points
    remove_column :users, :elimination_phase_points
  end
end
