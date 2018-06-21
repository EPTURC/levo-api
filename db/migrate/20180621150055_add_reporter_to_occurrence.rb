class AddReporterToOccurrence < ActiveRecord::Migration[5.2]
  def change
    add_reference :occurrences, :driver, foreign_key: true
  end
end
