module CellularAutomata
   class ElementaryCA
      attr_reader :current_gen, :rule_number, :width, :generations

      def initialize(width, rule = 22, generations = 50)
         @width = width
         @generations = generations

         #Set up the initial generation
         @current_gen = Array.new(width, '0')
         @current_gen[width / 2] = '1'

         #Set up the next generation
         @next_gen = Array.new(width, '0')

         #Set the rule
         set_rule rule
      end

      def set_rule(rule_number)
         #There are only 255 valid rule sets (2^8 - 1)
         raise RangeError.new('Rule number must be less than 256.') if rule_number > 256

         #Convert to binary and split
         @rule_number = rule_number
         @rule_array = rule_number.to_s(2).split('')

         #pad to 8 bits
         until @rule_array.length == 8 do
            @rule_array.unshift('0')
         end

      end

      def run(count = 0)

         #time to stop?
         return if count > @generations

         #print the current generation
         print_gen @current_gen

         #comput the next generation
         (1...@current_gen.length - 1).step do |i|
            @next_gen[i] = @rule_array[get_neighborhood(i)]
         end

         #Increment generations
         @current_gen = @next_gen

         #clear the next gen
         @next_gen = Array.new(@width, '0')

         run count + 1
      end

      private

      def get_neighborhood(index)
         #bounds check
         return 0 if index - 1 < 0 || index + 1 > @current_gen.length - 1

         #Convert the current neighborhood into a decimal number
         lookup = [@current_gen[index - 1], @current_gen[index], @current_gen[index + 1]]
         lookup.map{|val| val == '0' ? '1' : '0'}.join('').to_i(2)
      end

      def print_gen(gen)
         gen.each do |val|
            print "#{val == '0' ? ' ' : '*'} "
         end
         puts ''
      end
   end
end
