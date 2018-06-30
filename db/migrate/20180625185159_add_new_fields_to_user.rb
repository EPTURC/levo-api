class AddNewFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phone, :string
    add_column :users, :rg, :string
    add_column :users, :cpf, :string
    add_column :users, :adress, :string
  end
end

