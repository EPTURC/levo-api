class Task < ApplicationRecord
    self.inheritance_column = nil

    TYPE_OPTIONS = ['Entrega', 'Coleta']
    validates_inclusion_of :type, :in => TYPE_OPTIONS, message: "Invalid type. Valid options are: 'Entrega' and 'Coleta'"

    def as_json(options={})
        super(:only => [:id, :object, :responsible_name, :type, :local])
    end
end
