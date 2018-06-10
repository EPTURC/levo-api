class RemoveVehicleLocationFromLocation < ActiveRecord::Migration[5.2]
  def change
    remove_column :locations, :vehicle_location, :string
  end
end
