class CreateInviteUsers < ActiveRecord::Migration
  def change
    create_table :invite_users do |t|
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
