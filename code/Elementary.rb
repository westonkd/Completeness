#Small script to exercise ElementaryCA

require './ElementaryCA.rb'

#check arguments
if ARGV.length != 3
   puts "usage is APPLICATION_NAME <width> <rule_number> <generations_to_show>"
end

#Create the new ElementaryCA
eca = CellularAutomata::ElementaryCA.new(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i)

#run the ElementaryCA
eca.run
