class CreateSuscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :suscriptions do |t|
      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end
  end
end
