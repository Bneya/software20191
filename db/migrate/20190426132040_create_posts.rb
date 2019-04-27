class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :course_id
      t.text :content
      t.string :title
      t.float :rate
      t.references :course

      t.timestamps
    end
  end
end
