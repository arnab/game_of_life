module GameOfLife
  class Board
    # An indivisual cell in the Game {Board}
    class Cell
      STATES = [:live, :dead]
      # x is the vertical co-ordinate and y is the horizontal co-ordinate
      attr_accessor :state, :x, :y, :should_live_in_next_generation

      # Creates a {Cell}. A cell starts out as dead unless explicitly set alive.
      def initialize(x_coord, y_coord, initial_state=:dead)
        raise ArgumentError, "Unknown state #{initial_state}" unless STATES.include? initial_state
        raise ArgumentError, "Invalid x-coordinate #{x_coord}" unless x_coord >= 0
        raise ArgumentError, "Invalid y-coordinate #{y_coord}" unless y_coord >= 0
        @x, @y, @state = x_coord, y_coord, initial_state
      end

      def change_state_if_needed!
        if self.should_live_in_next_generation
          self.state = :live
        else
          self.state = :dead
        end
      end

      def cryptic_state
        case state
        when :live
          'X'
        when :dead
          '-'
        end
      end

      def to_s
        important_details = %w{state x y}.map {|attr| "#{attr}:#{self.send(attr)}"}
        "#{super} [#{important_details.join(' ')}]"
      end
    end
  end
end
