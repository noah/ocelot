module OCLT

  Java::OrgOdftoolkitSimple::PresentationDocument.class_eval do

    # look up an execution path for an undefined method
    def method_missing(name, *args, &block)
      if OCLT::Presentation.respond_to? name
        OCLT::Presentation.send name, *args, &block
      else
        # Set some mappings on a case-by-case basis
        puts "Not implemented: `#{self.class} -> #{name}`"
      end
    end

  end

  # ODF Presentation document type
  class Presentation

    def self.load(path, *args, &block)
      begin
        path = path[-4..-1] != ".odp" ? "#{path}.odp" : path
        @doc = PresentationDocument.load_document(path)
      rescue java.io.FileNotFoundException
        puts "#{path} does not exist."
        exit -1
      end
      block.arity < 1 ? @doc.instance_eval(&block) : block.call(@doc)
      self
    end

    # create a presentation
    def self.create(path, *args, &block)
      path = path[-4..-1] != ".odp" ? "#{path}.odp" : path
      @doc = PresentationDocument.new_presentation_document(*args)
      block.arity < 1 ? @doc.instance_eval(&block) : block.call(@doc)
      @doc.save(path)
    end

    def self.slide text
      @doc.new_slide(@doc.get_slide_count, text, SlideLayout::TITLE_PLUS_TEXT)
    end

    def self.slides
      puts block_given? ? "yes" : "no"
      @doc.get_slides
    end

    # def self.mode_toggle
    #   puts @doc.get_media_type_string
    #   @doc.change_mode(OdfMediaType::PRESENTATION_TEMPLATE)
    # end

  end

end
