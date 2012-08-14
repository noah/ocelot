include OCELOT

# Presentation tests
Presentation::create "pres-test" do
  # create individual slides
  slide "1"
  slide "2"
  slide "3"
  slide "4"

  # iterate over slides
  slides.each do |slide|
    puts "#{slide.index} => #{slide.name}"
  end
end


