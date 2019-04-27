class CreateCampuses < ActiveRecord::Migration[5.1]
  def change
    create_table :campuses do |t|
      t.string :name
      t.text :description
      t.string :location_map

      t.timestamps
    end
  end
end
