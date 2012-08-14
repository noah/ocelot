module OCELOT

  Java::OrgOdftoolkitSimple::PresentationDocument.class_eval do

    # look up an execution path for an undefined method
    def method_missing(name, *args, &block)
      if OCELOT::Presentation.respond_to? name
        OCELOT::Presentation.send name, *args, &block
      else
        # Set some mappings on a case-by-case basis
        puts "Not implemented: `#{self.class} -> #{name}`"
      end
    end

  end

  # ODF Presentation document type
  class Presentation < Doc

    # Create a presentation document
    def self.create(path, *args, &block)
      path = super path, ".odp", proc { PresentationDocument.new_presentation_document }
      block.arity < 1 ? @doc.instance_eval(&block) : block.call(@doc)
      @doc.save(path)
    end

    # Load an existing presentation document
    def self.load(path, *args, &block)
      path = super path, ".odp", PresentationDocument
      block.arity < 1 ? @doc.instance_eval(&block) : block.call(@doc)
      self
    end

    # Add a new slide to the the current presentation
    def self.slide text
      @doc.new_slide(@doc.get_slide_count, text, SlideLayout::TITLE_PLUS_TEXT)
    end

    # return the list of slides (iterator)
    def self.slides
      @doc.get_slides
    end

  end

end
