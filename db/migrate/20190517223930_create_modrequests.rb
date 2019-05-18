class CreateModrequests < ActiveRecord::Migration[5.1]
  def change
    create_table :modrequests do |t|
      t.string :user_id
      t.string :course_id

      t.timestamps
    end
  end
end
