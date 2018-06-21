class Vehicle < ApplicationRecord
    has_many :locations

    ONE_METER = 1
    NM_TO_METER = 1852

    def as_json(options={})
      super(:only => [:id, :company_id], :include => { last_location: { only: [:latitude, :longitude, :created_at] }}, :methods => [:status] )
    end

    def last_location
      self.locations.last
    end

    def is_stopped
      last_3 = self.locations.last(3)
      v1 = last_3.first
      v2 = last_3.second
      v3 = last_3.third
      if (v2.nil? && v3.nil?)
        true
      elsif (v3.nil?)
        if (dist(v1, v2) < ONE_METER)
          true
        else
          false
        end
      else
        if (dist(v1, v2) < ONE_METER && dist(v1, v3) < ONE_METER && dist(v2, v3) < ONE_METER)
          true
        else
          false
        end
      false
      end
    end

    def dist(v1, v2)
      dla = ((v1.latitude.to_d - v2.latitude.to_d).abs) * NM_TO_METER
      dlo = ((v1.longitude.to_d - v2.longitude.to_d).abs) * NM_TO_METER
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
