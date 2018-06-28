class Task < ApplicationRecord
    self.inheritance_column = nil




    def as_json(options={})
        super(:only => [:id, :object, :responsible_name, :type, :local])
    end
end
