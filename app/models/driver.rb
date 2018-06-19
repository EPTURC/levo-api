class Driver < ApplicationRecord
  belongs_to :user
  has_one :vehicle

  def as_json(options={})
    super(:only => [:id, :user_id])
  end

end
