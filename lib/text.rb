module OCLT

  Java::OrgOdftoolkitSimple::TextDocument.class_eval do

    # look up an execution path for an undefined method
    def method_missing(name, *args, &block)
      if OCLT::Text.respond_to? name
        OCLT::Text.send name, *args, &block
      else
        # Set some mappings on a case-by-case basis
        puts "Not implemented: `#{self.class} -> #{name}`"
      end
    end

  end

  # ODF Text document type
  class Text < Doc

    # Create a text document
    def self.create(path, *args, &block)
      path = super path, ".odt", lambda { TextDocument.new_text_document }
      block.arity < 1 ? @doc.instance_eval(&block) : block.call(@doc)
      @doc.save(path)
    end

    # Load an existing text document
    def self.load(path, *args, &block)
      path = super path, ".odt", TextDocument
      block.arity < 1 ? @doc.instance_eval(&block) : block.call(@doc)
      self
    end

    # Add a new paragraph to the text document
    def self.paragraph str
      @doc.add_paragraph str
    end

    # Insert line break(s) into the text document
    def self.line_break n=1
      # TODO "line breaks" are not really part of the Simple API, and
      # overall semantics are questionable.
      last_paragraph = @doc.get_paragraph_by_reverse_index(0, false)
      0.upto(n) do
        last_paragraph << "\n"
      end
    end

    # Insert page break(s) into the text document
    def self.page_break n=1
      0.upto(n) do
        @doc.add_page_break
      end
    end

    # Returns an iterator over all paragraphs in the text document
    def self.paragraphs
      @doc.get_paragraph_iterator
    end

    # Creates a new table named `name`
    def self.table name, rows=1, cols=1
      Table.new_table(@doc, rows, cols)
    end

    # Table iterator
    def tables
      @doc.get_table_list
    end

    # Return a section by name
    def self.section name
      s = @doc.add_section name
    end

    # Section iterator
    def self.sections
      @doc.get_section_iterator
    end

    # Create a list
    def self.list elements=[]
      list = @doc.add_list
      elements.each{|elt| list.add_item elt}
      list
    end

    # List iterator
    def self.lists
      @doc.get_list_iterator
    end

    # Set the header of a text document
    def self.set_header txt
      header = @doc.get_header
      table = header.add_table(1, 2)
      table.get_cell_by_position(0, 0).set_string_value(txt)
      #cell = table.get_cell_by_position(1, 0)
      #cell.set_image(java.net.URI.new "...")
      header
    end

    # Set the footer of a text document
    def self.set_footer txt
      footer = @doc.get_footer
      table = footer.add_table(1, 1)
      table.get_cell_by_position(0, 0).set_string_value(txt)
      #cell = table.get_cell_by_position(1, 0)
      #cell.set_image(java.net.URI.new "...")
    end

    # Get the contents of the text file as a string
    def self.to_str
      EditableTextExtractor.new_odf_editable_text_extractor(@doc.get_content_root).get_text()
    end
    
  end

end
