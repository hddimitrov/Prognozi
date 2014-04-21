class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string   :phase_type
      t.integer  :phase_id
      t.integer  :host_id
      t.integer  :guest_id
      t.integer  :host_score
      t.integer  :guest_score
      t.string   :sign
      t.datetime :start_at
      t.integer  :code
      t.string   :location

      t.timestamps
    end
  end
end
