class Vehicle < ApplicationRecord
    has_many :locations
    belongs_to :driver

    def as_json(options={})
      super(:only => [:id, :company_id, :driver_id], :include => { last_location: { only: [:latitude, :longitude, :created_at] }}, :methods => [:status] )
    end

    def last_location
      self.locations.last
    end

    def is_stopped
      #to-do: calculate distance between last locations
      false
    end

    def status
      if (self.last_location.minutes_since_updated > 1)
        "offline" 
      elsif self.is_stopped
        "stopped" 
      else
        "moving" 
      end
    end

end
