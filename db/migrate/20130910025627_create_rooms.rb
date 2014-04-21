class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :tournament_id
      t.integer :creator_id
      t.boolean :q_public, default: false
      t.float   :m_score_points
      t.float   :m_sign_points
      t.float   :gs_position_1_points
      t.float   :e_ef_points
      t.float   :e_qf_points
      t.float   :e_sf_points
      t.float   :e_l_points
      t.float   :e_f_points
      t.float   :e_c_points

      t.timestamps
    end
  end
end
