include OCELOT

# Table tests 
Text::create "table-test" do

  # Creates a row-major 3x4 table named "my-table".  The coords are
  # optional
  line_break 5

  # create a 1x1 table
  table "my-table"

  page_break

  # create a 3x4 table
  table "my-table-sized", 3, 4 
end
