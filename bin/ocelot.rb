#!/usr/bin/env jruby
#
# = About OCeLoT (ODF Toolkit Command Line Tools)
#
# This program provides a DSL for creating and manipulating Open
# Document files.
#
# Author::      Noah K. Tilton
# Copyright::   Copyright (c) 2012 Noah K. Tilton
# License::     Apache 2.0

# Prepend the lib directory one level up to the library search path
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '../lib'))

Dir["./lib/jars/*.jar"].each do |jar|
  require jar
end

require "java"

# N.B.: '$' delimiter means java ENUM: http://jira.codehaus.org/browse/JRUBY-6092
%w[ 
  java.net.URI
  org.odftoolkit.simple.SpreadsheetDocument
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

require "ocelot"

# Program usage
def usage
  puts "java -jar #{$0} <input file>"
  exit -1
end

# Evaluate the input file
ocelot_script = ARGV[0]
if ocelot_script.nil?
  usage
else
  require ocelot_script
end
