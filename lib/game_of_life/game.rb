module GameOfLife
  class Game
    attr_accessor :inputter
    attr_accessor :outputter
    # the Game Board
    attr_reader :board

    # Creates the game.
    # @param [InPutter] the inputter that you want to use
    # @param [OutPutter] the outputter that you want to use
    # @example GameOfLife::Game.new(GameOfLife::Outputters::SimpleStringOutputter)
    def initialize(inputter, outputter)
      @inputter = inputter.new
      @outputter = outputter.new
    end

    # Takes the raw input data and parses that into a Board
    # @todo Perhaps there is opportunity to create different kinds of inputters that will do the parsing
    #   and this class will use that as a template, instead of trying to parse it itself.
    def seed(raw_input)
      @board = Board.new(self, inputter.parse(raw_input))
    end

    # The event by which the board transitions from the current to the next generation/state
    def tick
      @board.mark_and_sweep_for_next_generation!
    end

  end
end
