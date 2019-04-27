class ChangeBioToBeTextInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :bio, :text

  end
end
