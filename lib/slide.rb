module OCLT

  Java::OrgOdftoolkitSimplePresentation::Slide.class_eval do

    # Returns the name of the current slide
    def name
      self.get_slide_name
    end

    # Returns the index of the current slide
    def index
      self.get_slide_index
    end

  end

end
