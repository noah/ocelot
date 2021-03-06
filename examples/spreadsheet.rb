include OCELOT

# Notes about array syntax:
#
# * It's table[1,2] NOT table[1][2].  This has to do with the fact that
# ruby has an operator overload for single-dimensional [] but not (as
# far as I could tell) multi-dim [][]...[].
#
# * Access is column-major.

# Table tests 
Spreadsheet::create "spreadsheet-test" do

  # Create a new table.  Refer to it using quasi-array syntax
  # Implicitly this is identical to creating a new sheet.
  table = table "my-table"
  table[2,3] = "ohai"
  puts table[2,3]

  # Add a new sheet called "new sheet"
  # N.B. append_sheet returns a Table object, so this is the same as
  # creating a table
  sheet = sheet "new sheet"

  # Add some data to the sheet.
  0.upto 100 do |row|
    0.upto 10 do |col|
      sheet[col, row] = Time.now.to_s
    end
  end

end
