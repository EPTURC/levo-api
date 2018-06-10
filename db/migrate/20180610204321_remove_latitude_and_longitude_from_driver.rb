class RemoveLatitudeAndLongitudeFromDriver < ActiveRecord::Migration[5.2]
  def change
    remove_column :drivers, :latitude, :string
    remove_column :drivers, :longitude, :string
  end
end
