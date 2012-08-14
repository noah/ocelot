include OCELOT

# Paragraph stuff
Text::create "doc-test" do
  p = Text::paragraph %{Lebowski ipsum brandt can't watch though. Or he has to pay a hundred. No ma'am, I didn't mean to give the impression that we're police exactly. We're hoping that it will not be necessary to call the police. Dieter doesn't care about anything. He's a nihilist. Vee vant zat money, Lebowski. He suspects that the culprits might be the very people who, uh, soiled your rug, and you're in a unique position to confirm or, uh, disconfirm that suspicion.\n}
  p << "Actually, I had some more to say.\n"
  p.right
  p.bold

  line_break 5
  page_break 1

  p = paragraph "``^ that was a really cool paragraph"
  p.center
  p.italic

  # linkify the entire paragraph
  p.link "mailto:noahktilton@google.com"

  line_break

  # append a linked fragment
  p << ["google is pretty awesome", "http://google.com"]

  p.comment "this is a paragraph comment"

  p.heading_level 1

  # puts "p " + (p.is_heading? ? "is" : "is not") + " a heading."
  # puts "heading level of p is #{p.heading_level}"

  p = paragraph "My shiny new paragraph"

  # the paragraphs method is enumerable, and we can use anything that is
  # legal ruby.  so we can say, for example:
  paragraphs.find {|para| para.to_s.length > 1 }
  # to find all paragraphs of a certain character length
  # or
  paragraphs.map {|para| para.to_s.reverse}
  # to reverse the text of the document

  # TODO -- model sections after paragraphs.  does Simple API have a
  # add_section method?
end

# Print the entire document as a text file
Text::load "doc-test" do
  # note: overriding to_s doesn't work here
  puts self.to_str
end

# List stuff
#
#  note: .odt suffix is optional
#
Text::load "doc-test" do

  # create a list
  l = list %w[a b c d e f]

  # set the list header
  l.header "blah"

  puts "list is:\n#{l}\n"
  puts "items are:\n#{l.items}\n"
  puts "length is #{l.length}\n"
  puts "clearing ...\n"
  l.clear
  puts "new length is #{l.length}\n"

  # add some items (append == <<)
  l << 1
  l.append 2
  l.append 3
  l << %w{4 5 6}

  # indexing
  puts "first element is", l[0]

  # (re-)assignment
  l[0] = 42
  puts "after assignment\n"
  puts l

  # deletion
  l.delete_at(0)

  puts "after deletion\n"
  puts l
end
