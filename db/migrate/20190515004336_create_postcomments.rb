class CreatePostcomments < ActiveRecord::Migration[5.1]
  def change
    create_table :postcomments do |t|
      t.integer :post_id
      t.integer :user_id
      t.text :content
      t.float :rate

      t.timestamps
    end
  end
end
