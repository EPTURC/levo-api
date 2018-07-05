class AddNewFieldsToItineraryItem < ActiveRecord::Migration[5.2]
  def change
    add_column :itinerary_items, :details, :string
    add_column :itinerary_items, :success, :boolean
  end
end
