class ItineraryItem < ApplicationRecord
  belongs_to :itinerary
  belongs_to :task

  validates :index, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def as_json(options={})
    super(:only => [:index, :done, :id], :include => { task: { only: [:object, :responsible_name, :type, :local] }})
  end

end
