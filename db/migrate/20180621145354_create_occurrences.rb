class CreateOccurrences < ActiveRecord::Migration[5.2]
  def change
    create_table :occurrences do |t|
      t.string :type
      t.string :location
      t.string :description

      t.timestamps
    end
  end
end
