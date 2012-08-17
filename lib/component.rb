module OCELOT

  Java::OrgOdftoolkitSimple::Component.class_eval do
    # mappings ...  these could also be done in the individual classes
    # which derive from Component (Table, Cell, etc)
    def to_s()
      case self
        when Java::OrgOdftoolkitSimpleTable::Cell
          self.get_string_value()
        when Java::OrgOdftoolkitSimpleText::Paragraph
          self.get_text_content()
        else
          self.toString
      end
    end
  end

end
