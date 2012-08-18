module OCELOT

  Java::OrgOdftoolkitSimpleTable::Cell.class_eval do

    def << val
      self.set_string_value val
    end

  end

  # Note:
  #
  # Tables are row-major
  Java::OrgOdftoolkitSimpleTable::Table.class_eval do

    # Read table cell using array syntax
    def [] col, row
      self.get_cell_by_position col, row
    end

    # Set table cell using array syntax
    def []= col, row, value
      (self.get_cell_by_position col, row).set_string_value value
    end

  end

end
