class AddTypeAndLocalToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :type, :string
    add_column :tasks, :local, :string
  end
end
