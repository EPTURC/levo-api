class Driver < ApplicationRecord
  belongs_to :user
  has_one :vehicle

  def as_json(options={})
    super(:only => [:id, :user_id], :include => { is_driving: { only: [:id, :company_id] } } )
  end

  def is_driving
    self.vehicle
  end
end
