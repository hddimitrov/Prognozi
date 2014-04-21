class CreateEliminations < ActiveRecord::Migration
  def change
    create_table :eliminations do |t|
      t.integer :tournament_id
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
