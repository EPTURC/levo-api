class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :vehicle_location
      t.references :vehicle, foreign_key: true
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
