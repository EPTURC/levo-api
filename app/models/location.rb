class Location < ApplicationRecord
  belongs_to :vehicle

  def as_json(options={})
    super(:only => [:latitude, :longitude])
  end
end
