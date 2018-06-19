class Task < ApplicationRecord
    self.inheritance_column = nil

    TYPE_OPTIONS = ['Entrega', 'Coleta']
    validates_inclusion_of :type, :in => TYPE_OPTIONS

    def as_json(options={})
        super(:only => [:id, :object, :responsible_name, :type, :local])
    end
end
