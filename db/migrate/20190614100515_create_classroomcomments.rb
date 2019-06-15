class CreateClassroomcomments < ActiveRecord::Migration[5.1]
  def change
    create_table :classroomcomments do |t|
      t.integer :user_id
      t.integer :classroom_id
      t.text :content
      t.float :rate

      t.timestamps
    end
  end
end
