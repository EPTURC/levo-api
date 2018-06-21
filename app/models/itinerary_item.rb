class ItineraryItem < ApplicationRecord
  belongs_to :itinerary
  belongs_to :task
  validate :check_done
  validate :check_index

  validates :index, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def as_json(options={})
    super(:only => [:index, :done, :id], :include => { task: { only: [:object, :responsible_name, :type, :local] }})
  end

  def previous_on_itinerary
    self.itinerary.itinerary_items.order('index').last
  end

  def check_done
    if previous_on_itinerary
      if self.done == true && self.previous_on_itinerary.done != true 
        errors.add(:done, "Você deve marcar o item anterior como concluído primeiro.")
      end
    end
    true
  end

  def check_index
    if self.task.type == "Entrega"
      if !self.previous_on_itinerary || self.previous_on_itinerary.type != "Coleta"
        errors.add(:task, "Você não pode adicionar uma entrega nesse itinerário pois não há uma coleta antes.")
      end
    end
    true
  end

end
