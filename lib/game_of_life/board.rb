module GameOfLife
  class Board
    # The {Game} to which this board belongs
    attr_reader :game    

    # Creates the board
    # @param [Game] game the game to which this board belongs.
    # @param [2D Array<Symbol>] seed_data the data for the {Cell}s in the board, as an 2D array.
    def initialize(game, seed_data)
      @game = game
    end

    def view
      game.outputter.render(self)
    end
  end
end
