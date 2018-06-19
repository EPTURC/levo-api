class RemoveDriverFromVehicle < ActiveRecord::Migration[5.2]
  def change
    remove_reference :vehicles, :driver, foreign_key: true
  end
end
