class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :object
      t.string :responsible_name

      t.timestamps
    end
  end
end
