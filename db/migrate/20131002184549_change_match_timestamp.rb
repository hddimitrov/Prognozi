class ChangeMatchTimestamp < ActiveRecord::Migration
  def up
  	change_column :matches, :timestamp, :timestamp
  end

  def down
  	change_column :matches, :timestamp, :timestamp
  end
end
