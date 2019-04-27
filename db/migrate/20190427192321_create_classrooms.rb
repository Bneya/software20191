class CreateClassrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :classrooms do |t|
      t.text :title
      t.text :ubication
      t.integer :campus_id
      t.integer :rating_noise
      t.integer :rating_disponibility
      t.integer :rating_sockets

      t.timestamps
    end
  end
end
