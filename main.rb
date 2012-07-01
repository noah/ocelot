require "lib/oclt"

# creating a new TextDocument
#
OCLT::Text.generate("my.odt") do
  add_paragraph %{
    Yo ho ho and a bottle of rum.  This is my really looooooooooooooooooooooooooooooooong
    ...
    ...
    paragraph.
  }
  # N.B.:  Foo::Bar::Klass.constants prints that class' ENUMs
  change_mode OdfMediaType::TEXT_MASTER

  puts get_mode # not implemented in SimpleAPI
end

# Loading the document we created, applying some additional
# modifications, and saving it back.
#
OCLT::Text.load("my.odt") do
  page_break
  para = add_paragraph("This is a second paragraph!\n\n\r\n")
  para.set_horizontal_alignment(HorizontalAlignmentType::CENTER)
  para.append_text_content("... with some appended language!")
  font = para.get_font()
  font.set_font_style(FontStyle::ITALIC)
  para.set_font(font)
  para.append_hyperlink "mail to me", URI.new("mailto:noahktilton@gmail.com")
  add_page_break(para)
  paragraphs.each_with_index{|para, i| puts "Paragraph #{i}: #{para}" }
  change_mode(OdfMediaType::TEXT_WEB)
end
