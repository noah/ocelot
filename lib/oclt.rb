# ODF Toolkit Command Line Tools
#
# This program provides a DSL for creating and manipulating Open
# Document files.
#
# Author::      Noah K. Tilton
# Copyright::   Copyright (c) 2012 Noah K. Tilton
# License::     Apache 2.0
#
require "java"


# N.B.: '$' delimiter means java ENUM: http://jira.codehaus.org/browse/JRUBY-6092
%w[ 
  java.net.URI
  org.odftoolkit.simple.PresentationDocument
  org.odftoolkit.simple.Component
  org.odftoolkit.simple.TextDocument
  org.odftoolkit.simple.TextDocument$OdfMediaType
  org.odftoolkit.simple.style.StyleTypeDefinitions$HorizontalAlignmentType
  org.odftoolkit.simple.style.StyleTypeDefinitions$FontStyle
].each {|klass| java_import klass}

uri = java.net.URI.new("http://www.google.com")

# See: https://github.com/jruby/jruby/wiki/Persistence
# But the recommended fix doesn't work.  Seems harmless
# TextDocument.__persistent__ = true  FIXME

# This module contains the different types of documents
module OCLT

  # A generic document type
  class Doc; end

  # ODF Text type
  class Text < Doc

    def initialize
      @doc = nil
    end

    # Insert a page break into the current document
    def self.page_break
      @doc.add_page_break
    end

    # Returns an iterator over all paragraphs in the document
    def self.paragraphs
      @doc.get_paragraph_iterator
    end

    # Loads an existing document from disk
    def self.load(file, *args, &block)
      @doc = TextDocument.load_document(file)
      block.arity < 1 ? @doc.instance_eval(&block) : block.call(@doc)
      @doc.save(file) # TODO: only call save on load()ed docs if something changes
      block
    end

    # Creates a new document and save it on disk
    def self.generate(file, *args, &block)
      @doc = TextDocument.new_text_document(*args)
      block.arity < 1 ? @doc.instance_eval(&block) : block.call(@doc)
      @doc.save(file)
    end

  end

  # Other high-level types
  
  # ODF presentation type TODO
  # class Presentation < Doc
  #   def self.generate(file, *args, &block)
  #     doc = PresentationDocument.new_presentation_document(*args)
  #     block.arity < 1 ? doc.instance_eval(&block) : block.call(doc)
  #   end
  # end

  # TODO -- Tables should probably be automagically added to the
  # document when created in block scope.
  #
  # ODF table type
  # class Table < Doc
  #   def self.generate(file, *args, &block)
  #     table = Table.new_table(document)
  #     # table.name = ?
  #   end
  # end
end

# Map OCLT methods => ODF Simple API methods
# See http://ruby-doc.org/core-1.9.3/Module.html#method-i-class_eval
#
# Add some sugar to the Component class
Java::OrgOdftoolkitSimple::Component.class_eval  {
  # Prints paragraph text without need to call separate function
  # Works for Paragraphs, might need to do some inspection for other
  # types.
  def to_s()
    self.get_text_content()
  end
}
#
# Add some sugar to the TextDocument class
Java::OrgOdftoolkitSimple::TextDocument.class_eval {

  # look up an execution path for an undefined method
  #
  def method_missing(name, *args, &block)
    if OCLT::Text.respond_to? name
      OCLT::Text.send name, *args, &block
    else
      # Set some mappings on a case-by-case basis
      # case name.to_s
      # when /^paragraph/
      #   send paragraph, *args, &block
      # end
      puts "Not yet implemented: `#{name}`"
    end
  end

}
