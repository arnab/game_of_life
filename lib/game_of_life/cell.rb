module GameOfLife
  class Board
    # An indivisual cell in the Game {Board}
    class Cell
      STATES = [:live, :dead]
      attr_accessor :state, :should_live_in_next_generation
      # Number of generations this has lived through
      attr_reader :age

      # Creates a {Cell}. A cell starts out as dead unless explicitly set alive.
      def initialize(initial_state=:dead)
        raise ArgumentError, "Unknown state #{initial_state}" unless STATES.include? initial_state
        @state = initial_state
        @age = 0
      end

      def change_state_if_needed!
        if self.should_live_in_next_generation
          @age += 1
          self.state = :live
        else
          @age = 0
          self.state = :dead
        end
      end

      def alive?
        state == :live
      end

      def dead?
        ! alive?
      end

      def old?
        @age > 3
      end

      def to_s
        fields = %w{state should_live_in_next_generation}
        important_details = fields.map {|attr| "#{attr}:#{self.send(attr)}"}
        "#{super} <#{important_details.join(' ')}>"
      end
    end
  end
end
