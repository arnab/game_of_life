module GameOfLife
  class Game
    attr_accessor :outputter
    # the Game Board
    attr_reader :board

    # Creates the game.
    # @param [OutPutter] the outputter that you want to use
    # @example GameOfLife::Game.new(GameOfLife::Outputters::SimpleStringOutputter)
    def initialize(outputter)
      @outputter = outputter.new
    end

    # Takes the raw input data and parses that into a Board
    # @todo Perhaps there is opportunity to create different kinds of inputters that will do the parsing
    #   and this class will use that as a template, instead of trying to parse it itself.
    def seed(raw_input)
      @board = Board.new(self, parse(raw_input))
    end

    # The event by which the board transitions from the current to the next generation/state
    def tick
      
    end

    private
      def parse(input)
        rows = input.split("\n")
        rows.map! { |row| row.split(' ') }
        rows.map! do |row|
          row.map! { |symbol| convert_cryptic_symbol_to_state(symbol) }
        end
        rows
      end

      def convert_cryptic_symbol_to_state(symbol)
        case symbol
        when 'X'
          :live
        when '-'
          :dead
        end
      end
  end
end
