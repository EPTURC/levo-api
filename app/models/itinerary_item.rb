class ItineraryItem < ApplicationRecord
  belongs_to :itinerary
  belongs_to :task
end
