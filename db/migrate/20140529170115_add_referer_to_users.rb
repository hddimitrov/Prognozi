class AddRefererToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :referer_name, :string
  end
end
