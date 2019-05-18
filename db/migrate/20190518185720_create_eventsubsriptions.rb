class CreateEventsubsriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :eventsubsriptions do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
