class RenameCompanyIdToCompanyIdInVehicles < ActiveRecord::Migration[5.2]
  def change
    remove_column :vehicles, :company_id, :integer
    add_column :vehicles, :company_id, :string
  end
end
