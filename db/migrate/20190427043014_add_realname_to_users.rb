class AddRealnameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :realname, :string
  end
end
