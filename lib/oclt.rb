require "java"

java_import "org.odftoolkit.simple.TextDocument"

doc = TextDocument.new_text_document()

doc.add_paragraph(%{eos
    Hello from ODF Toolkit and jruby!
    Cool beans ...
})

doc.save("/tmp/test.odt")

puts "Wrote new odf document to /tmp/test.odt."
