module OCELOT

  Java::OrgOdftoolkitSimple::SpreadsheetDocument.class_eval do

    # look up an execution path for an undefined method
    def method_missing(name, *args, &block)
      if OCELOT::Spreadsheet.respond_to? name
        OCELOT::Spreadsheet.send name, *args, &block
      else
        puts "Not implemented: `#{self.class} -> #{name}`"
      end
    end

  end

  # ODF Spreadsheet document type
  class Spreadsheet < Doc

    # Create a text document
    def self.create(path, *args, &block)
      path = super path, ".ods", proc { SpreadsheetDocument.new_spreadsheet_document }
      block.arity < 1 ? @doc.instance_eval(&block) : block.call(@doc)
      @doc.save(path)
    end

    # Load an existing text document
    def self.load(path, *args, &block)
      path = super path, ".ods", SpreadsheetDocument
      block.arity < 1 ? @doc.instance_eval(&block) : block.call(@doc)
      self
    end

    # Add a table with matrix data
    def self.table name
      table = @doc.add_table
      table.set_table_name name
      table
    end

    # Table iterator
    def self.tables
      @doc.get_table_list
    end

    # Create a new named sheet
    def self.sheet name
      @doc.append_sheet name
    end

  end

end
