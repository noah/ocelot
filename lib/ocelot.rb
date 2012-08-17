# = About OCeLoT (ODF Toolkit Command Line Tools)
#
# This program provides a DSL for creating and manipulating Open
# Document files.
#
# Author::      Noah K. Tilton
# Copyright::   Copyright (c) 2012 Noah K. Tilton
# License::     Apache 2.0

module OCELOT
  version_file = File.expand_path(File.dirname(__FILE__) + "/../VERSION")
  # The current version number
  VERSION      = File.read(version_file).strip
end

%w[
  doc
  text
  presentation
  spreadsheet
  paragraph
  slide
  table
  list
  component
].each {|file| require file }
