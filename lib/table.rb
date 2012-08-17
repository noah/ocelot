module OCELOT

  Java::OrgOdftoolkitSimpleTable::Cell.class_eval do

    def << val
      self.set_string_value val
    end

  end

  Java::OrgOdftoolkitSimpleTable::Table.class_eval do

    # Read table cell using array syntax
    def [] x, y
      self.get_cell_by_position x, y
    end

    # Set table cell using array syntax
    def []= x, y, value
      (self.get_cell_by_position x, y).set_string_value value
    end

  end

end
