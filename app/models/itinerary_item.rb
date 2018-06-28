class ItineraryItem < ApplicationRecord
  belongs_to :itinerary
  belongs_to :task
  validate :check_done
  validate :check_index

  validates :index, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def as_json(options={})
    super(:only => [:index, :done, :id], :include => { task: { only: [:object, :responsible_name, :type, :local] }})
  end

  def previous_pending_on_itinerary
    if self.index > 1
      previous = self.index - 1
      self.itinerary.itinerary_items.where(done: false).find_by(index: previous)
    end
  end

  def previous_on_itinerary
    if self.index > 1
      previous = self.index - 1
      self.itinerary.itinerary_items.find_by(index: previous)
    end
  end

  def check_done
    if previous_pending_on_itinerary && self.done == true
        errors.add(:done, "Você deve marcar o item anterior como concluído primeiro.")
    end
    true
  end

  def check_index
    if self.task.type == "Entrega"
      if !self.previous_on_itinerary || self.previous_on_itinerary.task.type != "Coleta"
        errors.add(:task, "Você não pode adicionar uma entrega nesse itinerário pois não há uma coleta antes.")
      end
    end
    true
  end

end
