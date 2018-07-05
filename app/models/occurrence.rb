class Occurrence < ApplicationRecord
    self.inheritance_column = nil

    belongs_to :itinerary
end
