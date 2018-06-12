class Vehicle < ApplicationRecord
    has_many :locations

    def as_json(options={})
      super(:only => [:id, :company_id], :include => { locations: { only: [:latitude, :longitude, :created_at] } })
    end
end
