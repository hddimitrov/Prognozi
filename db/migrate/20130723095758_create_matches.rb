class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :phase_type
      t.integer :phase_id
      t.integer :host_id
      t.integer :guest_id
      t.integer :host_score
      t.integer :guest_score
      t.string :result
      t.datetime :start_at

      t.timestamps
    end
  end
end
