module OCELOT

  # The general idea here is to map OCELOT methods => ODF Simple API
  # methods See http://ruby-doc.org/core-1.9.3/Module.html#method-i-class_eval

  Java::OrgOdftoolkitSimple::Component.class_eval do
    # Prints paragraph text without need to call separate function
    # Works for Paragraphs, might need to do some inspection for other
    # types.
    def to_s()
      if self.class == Java::OrgOdftoolkitSimpleText::Header
        puts self.toString
      else
        self.get_text_content()
      end
    end
  end

  Java::OrgOdftoolkitSimpleText::Paragraph.class_eval do

    # meta-methods for paragraph alignment
    # i.e., methods for center, left, right, default, justify
    HorizontalAlignmentType.constants.each do |alignment|
      class_eval <<-CODE, __FILE__, __LINE__
        def #{alignment.downcase}
          self.set_horizontal_alignment HorizontalAlignmentType::#{alignment}
        end
      CODE
    end

    # meta-methods for font styles
    # i.e., methods for italic, bolditalic, regular, bold
    FontStyle.constants.each do |style|
      class_eval <<-CODE, __FILE__, __LINE__
        def #{style.downcase}
          font = self.get_font
          font.set_font_style FontStyle::#{style}
          self.set_font font
        end
      CODE
    end

    # Append text or linked text to a paragraph
    def << param
      if param.class == Array
        # append a linked textual fragment
        param[1] = java.net.URI.new(param[1])
        self.append_hyperlink *param
      else
        # append a textual fragment
        self.append_text_content param
      end
      self
    end

    # Linkify an entire paragraph
    def link uri
      self.apply_hyperlink java.net.URI.new(uri)
    end

    # Add a comment (annotation) to the beginning of a paragraph
    def comment str
<<<<<<< HEAD
      self.add_comment("This is a paragraph comment for the paragraph", "OCLT Commenter");
=======
      self.add_comment("This is a paragraph comment for the paragraph", "OCELOT Commenter");
>>>>>>> gh-pages
    end

    # Whether the current paragraph is a heading
    def heading?
      self.is_heading?
    end

    # Gets the current heading level of this paragraph.  Returns 0 if
    # none.
    def heading_level
      self.get_heading_level
    end

    def heading_level level=1
      self.apply_heading(true, level)
    end

  end

end
