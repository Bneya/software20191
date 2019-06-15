class CreateClassrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :classrooms do |t|
      t.text :title
      t.text :ubication
      t.integer :campus_id

      t.timestamps
    end
  end
end
