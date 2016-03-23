require ‘rubygame‘

Width = 640
Height = 400
module Rubygame
   class Surface
      def put_pixel(point, color)
         self.draw_box point, point, color
      end
   end
end

class RandomPixels
   include Rubygame

   def initialize
      @screen = Screen.new [Width, Height]
      @events = EventQueue.new

      @screen.fill [0, 0, 0]
      @screen.update
   end

   def event_loop
      loop do
         @events.each { |event|
            case event
            when QuitEvent
               return
            end
         }

         draw
         @screen.update
      end
   end

   def draw
      point = [rand(Width), rand(Height)]
      color = [rand(255), rand(255), rand(255)]
      @screen.put_pixel point, color
   end
end

Rubygame.init
RandomPixels.new.event_loop
Rubygame.quit
