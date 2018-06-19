class Driver < ApplicationRecord
  belongs_to :user

  def as_json(options={})
    super(:only => [:id, :user_id])
  end

end
