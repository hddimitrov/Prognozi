class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :host
      t.string :guest
      t.integer :host_score
      t.integer :guest_score
      t.integer :tournament_id
      t.string :timestamp
      t.string :level

      t.timestamps
    end
  end
end
