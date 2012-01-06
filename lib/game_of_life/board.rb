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
    # @example seed_data looks like
    #   the output of SimpleStringInputter#parse
    # @raise [ArgumentError] if the seed_data is not in the shape of a square,
    #   or if all elements are not present
    def initialize(game, seed_data)
      validate_seed_data(seed_data)
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
      def validate_seed_data(seed_data)
        rows_found = seed_data.size

        columns_in_each_row = seed_data.map(&:size)
        unless columns_in_each_row.uniq.size == 1
          msg = "Unequal number of columns, #{columns_in_each_row.inspect} in different rows found"
          fail_with(seed_data, msg)
        end

        columns_found = columns_in_each_row.uniq.first
        unless rows_found == columns_found
          msg = "Number of rows [#{rows_found}] != number of columns [#{columns_found}]"
          fail_with(seed_data, msg)
        end

        elements_found = seed_data.flatten.reject {|d| d.nil? }.size
        unless (rows_found ** 2) == elements_found
          msg = "Not all elements are filled with valid data."
          fail_with(seed_data, msg)
        end
      end

      def fail_with(message, seed_data)
        raise ArgumentError, "Cannot create a board with seed_data: #{seed_data.inspect}" +
        "(Reason: #{message})"
      end

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
