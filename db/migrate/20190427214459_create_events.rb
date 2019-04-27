class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.text :title
      t.text :description
      t.integer :classroom_id
      t.integer :course_id
      t.integer :schedule
      t.integer :day
      t.string :event_type
      t.integer :actual_users
      t.integer :max_users
      t.integer :price

      t.timestamps
    end
  end
end
