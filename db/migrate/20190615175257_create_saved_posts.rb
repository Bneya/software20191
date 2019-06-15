class CreateSavedPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :saved_posts do |t|
      t.string :user_id
      t.string :post_id

      t.timestamps
    end
  end
end
