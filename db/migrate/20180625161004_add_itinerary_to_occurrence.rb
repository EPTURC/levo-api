class AddItineraryToOccurrence < ActiveRecord::Migration[5.2]
  def change
    add_reference :occurrences, :itinerary, foreign_key: true
  end
end
