module GameOfLife
  class Board
    # An indivisual cell in the Game {Board}
    class Cell
      STATES = [:live, :dead]
      attr_accessor :state, :x, :y

      def initialize(initial_state, x_coord, y_coord)
        raise ArgumentError, "Unknown state #{initial_state}" unless STATES.include? initial_state
        #TODO: Maybe we should do bound based checks instead, dimensions being set when the game/board is created
        raise ArgumentError, "Invalid x-coordinate #{x_coord}" unless x_coord >= 0
        raise ArgumentError, "Invalid y-coordinate #{y_coord}" unless y_coord >= 0
        @state, @x, @y = initial_state, x_coord, y_coord
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
