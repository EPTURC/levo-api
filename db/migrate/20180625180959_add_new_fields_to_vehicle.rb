class AddNewFieldsToVehicle < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :license_plate, :string
    add_column :vehicles, :model, :string
    add_column :vehicles, :color, :string
  end
end
