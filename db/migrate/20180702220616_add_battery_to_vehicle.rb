class AddBatteryToVehicle < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :battery, :integer
  end
end
