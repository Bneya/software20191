class CreateEventposts < ActiveRecord::Migration[5.1]
  def change
    create_table :eventposts do |t|
      t.text :title
      t.integer :user_id
      t.integer :event_id
      t.text :content
      t.float :rate

      t.timestamps
    end
  end
end
