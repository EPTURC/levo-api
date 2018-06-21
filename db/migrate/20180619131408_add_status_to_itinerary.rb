class AddStatusToItinerary < ActiveRecord::Migration[5.2]
  def change
    add_column :itineraries, :status, :string
  end
end
