# = About OCLT (ODF Toolkit Command Line Tools)
#
# This program provides a DSL for creating and manipulating Open
# Document files.
#
# Author::      Noah K. Tilton
# Copyright::   Copyright (c) 2012 Noah K. Tilton
# License::     Apache 2.0

$:.unshift File.expand_path(File.dirname(__FILE__))

module OCLT
  version_file = File.expand_path(File.dirname(__FILE__) + "/../VERSION")
  VERSION      = File.read(version_file).strip
end


require "java"

# N.B.: '$' delimiter means java ENUM: http://jira.codehaus.org/browse/JRUBY-6092
%w[ 
  java.net.URI
  org.odftoolkit.simple.PresentationDocument
  org.odftoolkit.simple.Component
  org.odftoolkit.simple.table.Table
  org.odftoolkit.simple.TextDocument
  org.odftoolkit.simple.TextDocument$OdfMediaType
  org.odftoolkit.simple.style.StyleTypeDefinitions$HorizontalAlignmentType
  org.odftoolkit.simple.style.StyleTypeDefinitions$FontStyle
  org.odftoolkit.simple.common.TextExtractor
  org.odftoolkit.simple.common.EditableTextExtractor
  org.odftoolkit.simple.presentation.Slide$SlideLayout
].each {|klass| java_import klass}

%w[
  doc
  text
  presentation
  paragraph
  slide
  list
].each {|file| require file }
