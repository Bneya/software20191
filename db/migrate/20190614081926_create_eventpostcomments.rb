class CreateEventpostcomments < ActiveRecord::Migration[5.1]
  def change
    create_table :eventpostcomments do |t|
      t.integer :user_id
      t.integer :eventpost_id
      t.text :content
      t.float :rate

      t.timestamps
    end
  end
end
