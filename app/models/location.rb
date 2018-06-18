class Location < ApplicationRecord
  belongs_to :vehicle

  def as_json(options={})
    super(:only => [:latitude, :longitude, :created_at])
  end

  def minutes_since_updated
    (Time.current - self.created_at) / 1.minute
  end

end
