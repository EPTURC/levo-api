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
      last = self.locations.last(3)
      v1 = last[0]
      v2 = last[1]
      v3 = last[2]
      if (v2.nil? && v3.nil?)
        true
      elsif (v3.nil?)
        if (dist(v1, v2) < 1)
          true
        else
          false
        end
      else
        if (dist(v1, v2) < 1 && dist(v1, v3) < 1 && dist(v2, v3) < 1)
          true
        else
          false
        end
      false
      end
    end

    def dist(v1, v2)
      dla = ((v1.latitude.to_d - v2.latitude.to_d).abs) * 1852
      dlo = ((v1.longitude.to_d - v2.longitude.to_d).abs) * 1852
      Math.sqrt(dla ** 2 + dlo ** 2)
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
