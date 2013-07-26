class CreateFbUsers < ActiveRecord::Migration
  def change
    create_table :fb_users do |t|
      t.string :provider
      t.string :fbuid
      t.string :name
      t.string :oath_token
      t.datetime :oath_expires_at

      t.timestamps
    end
  end
end
