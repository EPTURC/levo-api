class AddDrivenByToVehicles < ActiveRecord::Migration[5.2]
  def change
    add_reference :vehicles, :driver, index: true
    add_foreign_key :vehicles, :drivers
  end
end
