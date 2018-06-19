class Itinerary < ApplicationRecord
  belongs_to :vehicle
  belongs_to :driver
  has_many :itinerary_items

  STATUS_OPTIONS = ['ativo', 'inativo']
  validates_inclusion_of :status, :in => STATUS_OPTIONS, message: "Invalid status. Valid options are: 'ativo' and 'inativo'"

  def items
    self.itinerary_items.order('index')
  end


end
