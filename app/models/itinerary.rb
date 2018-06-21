class Itinerary < ApplicationRecord
  belongs_to :vehicle
  belongs_to :driver
  has_many :itinerary_items
  validate :check_driver
  validate :check_vehicle

  STATUS_OPTIONS = ['ativo', 'inativo']
  validates_inclusion_of :status, :in => STATUS_OPTIONS, message: "Invalid status. Valid options are: 'ativo' and 'inativo'"

  def items
    self.itinerary_items.order('index')
  end

  def check_driver
    if Itinerary.where(status: 'ativo', driver: self.driver).exist?
      errors.add(:driver, "Não foi possível adicionar este motorista a este itinerário, pois ele já está em outro itinerário ativo")
    end
  end

  def check_vehicle
    if Itinerary.where(status: 'ativo', driver: self.vehicle).exist?
      errors.add(:vehicle, "Não foi possível adicionar este veículo a este itinerário, pois ele já está em outro itinerário ativo")
    end
  end

end
