class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :longitude
      t.string :latitude
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
