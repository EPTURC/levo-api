class Vehicle < ApplicationRecord
    has_many :locations

    def as_json(options={})
      super(:only => [:id, :company_id], :include => { last_location: { only: [:latitude, :longitude, :created_at] } })
    end

    def last_location
      self.locations.last
    end

end
