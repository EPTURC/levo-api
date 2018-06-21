class Driver < ApplicationRecord
  belongs_to :user

  def as_json(options={})
    super(:only => [:id], :include => { user: { only: [:name, :id] }})
  end

end
