class Itinerary < ApplicationRecord
  belongs_to :vehicle
  belongs_to :driver
  has_many :itinerary_items
  has_many :occurrences

  STATUS_OPTIONS = ['ativo', 'inativo']
  validates_inclusion_of :status, :in => STATUS_OPTIONS, message: "Invalid status. Valid options are: 'ativo' and 'inativo'"

  def items
    self.itinerary_items.order('index')
  end

  def situation
    situation = {
      'vehicle' => self.situation_items,
      'color'=> self.situation_color
    }
    return situation
  end

  def situation_color
    if self.has_active_occurrence
      'red'
    elsif self.vehicle.status == 'offline'
      'gray'
    else
      'green'
    end
  end

  def situation_items
    self.itinerary_items.first.task.type if self.itinerary_items.first
  end
  
  def has_active_occurrence
    !self.occurrences.last.solved if self.occurrences.last
  end

end
