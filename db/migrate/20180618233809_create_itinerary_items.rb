class CreateItineraryItems < ActiveRecord::Migration[5.2]
  def change
    create_table :itinerary_items do |t|
      t.references :itinerary, foreign_key: true
      t.integer :index
      t.boolean :done
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
