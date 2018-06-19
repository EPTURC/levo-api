class Itinerary < ApplicationRecord
  belongs_to :vehicle
  belongs_to :driver
  has_many :itinerary_items

  STATUS_OPTIONS = ['ativo', 'inativo']
  validates_inclusion_of :status, :in => STATUS_OPTIONS

  def items
    self.itinerary_items.order('index')
  end

end
