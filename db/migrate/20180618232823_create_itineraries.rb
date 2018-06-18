class CreateItineraries < ActiveRecord::Migration[5.2]
  def change
    create_table :itineraries do |t|
      t.references :vehicle, foreign_key: true
      t.references :driver, foreign_key: true

      t.timestamps
    end
  end
end
