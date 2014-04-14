class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.integer :room_id
      t.string :uid
      t.string :status

      t.timestamps
    end
  end
end
