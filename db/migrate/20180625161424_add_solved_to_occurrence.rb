class AddSolvedToOccurrence < ActiveRecord::Migration[5.2]
  def change
    add_column :occurrences, :solved, :boolean, :default => false
  end
end
