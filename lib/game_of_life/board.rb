module GameOfLife
  # The board used in the game. Holds the {Cell}s.
  class Board
    # The {Game} to which this board belongs
    attr_reader :game
    # The {Cell}s in this board,internally maintained as a 2D Array of {Cell}s.
    # Use {#each_cell}, {#each_row} etc. methods to access the cells indivisually.
    attr_reader :cells

    # Creates the board
    # @param [Game] game the game to which this board belongs.
    # @param [2D Array<Symbol>] seed_data the data for the {Cell}s in the board, as an 2D array.
    # The symbols are asserted to be either :alive or :dead
    def initialize(game, seed_data)
      @game = game
      @cells = Array.new(Array.new)
      seed_with!(seed_data)
    end

    def view
      game.outputter.render(self)
    end

    def each_row(&block)
      @cells.each { |row| yield row }
    end

    private
      def seed_with!(data)
        data.each_with_index do |row, x|
          @cells << []
          row.each_with_index do |state, y|
            @cells[x] << Cell.new(state, y, x)
          end
        end
      end
  end
end
