module CellularAutomata
   #############################################################################
   #
   #
   #
   #############################################################################
   class ElementaryCA
      attr_reader :start_state, :rule_set     #Initial state of the CA
      def initialize(start_state, options = {})
         @start_state = start_state
         @current_state = start_state
         @next_state = Array.new

         set_rule_set(options[:rule_set] || 22)
      end

      def set_rule_set(rule_set)
         #Valid rules range from 0-255
         raise Exception.new("Rule must be less than 256") if rule_set > 255

         #Set the rule set property
         @rule_set = rule_set

         #create an array of the binary representaiton
         @rule_bin_array = rule_set.to_s(2).split('')

         #make sure we have 8 bits
         until (@rule_bin_array.length == 8) do
            @rule_bin_array.unshift('0')
         end
      end

      def start
         #print the current generation
         print_state @current_state

         #calculate the next generation
         @current_state.each_with_index do |value, index|
            if index > 0 && index < @current_state.length - 1
               #Get the decimal representation of the neighborhood
               current_nh = get_neighborhood(index)

               #Get the next state of the current agent
               @next_state << @rule_bin_array[current_nh]
            end
         end

         #set the current state to next state
         @current_state = @next_state

         #Delete the old next state
         @next_state = Array.new

         #recurse
         start if @current_state.length > 1
      end

      private

      def print_state(step)
         #center the output
         (@start_state.length - step.length).times {print ' '}

         step.each do |val|
            print "#{val == '0' ? '_' : '*'} "
         end
         puts ''
      end

      def get_neighborhood(index)
         return 0 if index - 1 < 0 || index + 1 > @current_state.length

         (@current_state[index - 1].to_s +
         @current_state[index].to_s +
         @current_state[index + 1].to_s).to_i(2)
      end
   end
end

test = CellularAutomata::ElementaryCA.new([1])
test.start
