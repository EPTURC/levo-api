class ItineraryItem < ApplicationRecord
  belongs_to :itinerary
  belongs_to :task

  def as_json(options={})
    super(:only => [:index, :done, :id], :include => { task: { only: [:object, :responsible_name, :type, :local] }})
  end

end
