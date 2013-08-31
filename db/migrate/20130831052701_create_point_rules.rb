class CreatePointRules < ActiveRecord::Migration
  def change
    create_table :point_rules do |t|
      t.integer :room_id
      t.integer :result_points
      t.integer :exact_result
      t.integer :group_winner_points
      t.integer :quarter_finalist_points
      t.integer :semi_finalist_points
      t.integer :final_points
      t.string :winner

      t.timestamps
    end
  end
end
