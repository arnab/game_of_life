module GameOfLife
  # The board used in the game. Holds the {Cell}s.
  class Board
    # The {Game} to which this board belongs
    attr_reader :game

    # The {Cell}s in this board,internally maintained as a 2D Array of {Cell}s.
    # The x-coordinate increases horizontally and is always positive.
    # The y-coordinate increases vertically and is always positive.
    # Internally, the cells are arranged as a 2D array. The first-level Array indexed
    # with the y-coordinates. It contains an Array of {Cell}s, whose position is
    # the x-coordinate.
    # @note Use {#each_cell}, {#each_row} etc. methods to access the cells individually.
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

    def each_cell(&block)
      @cells.flatten.each { |cell| yield cell }
    end

    # Find the cell at a given pair of co-ordinates. Following Array symantics,
    # this method returns nil if nothing exists at that location or if the
    # location is out of the board. To avoid {Array} negative index symantics it
    # returns nill if a negative index is passed.
    # @param [Integer] x the x-coordinate
    # @param [Integer] y the y-coordinate
    # @return [Cell] or nil
    def cell_at(x, y)
      return nil if (x < 0 || y < 0)
      @cells[y][x] if @cells[y]
    end

    # Finds the neighbors of a given {Cell}. The neighbors are the eight cells
    # that surround the given one.
    # @param [Cell] cell the cell you find the neighbors of
    # @return [Array<Cell>]
    def neighbors_of(cell)
      neighbors = coords_of_neighbors(cell.x, cell.y).map { |x, y| self.cell_at(x, y) }
      neighbors.reject {|n| n.nil?}
    end

    def mark_and_sweep_for_next_generation!
      mark_changes_for_next_generation
      sweep_changes_for_next_generation!
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
        elements_found = seed_data.flatten.reject {|d| d.nil? }.size
        unless (rows_found * columns_found) == elements_found
          msg = "Not a rectangular shape: " +
            "rows(#{rows_found}) x columns(#{columns_found}) != total elements(#{elements_found})]"
            "Probably not all elements are filled with valid data."
          fail_with(seed_data, msg)
        end
      end

      def fail_with(message, seed_data)
        raise ArgumentError, "Cannot create a board with seed_data: #{seed_data.inspect}" +
        "(Reason: #{message})"
      end

      def seed_with!(data)
        data.each_with_index do |row, y|
          @cells << []
          row.each_with_index do |state, x|
            @cells[y] << Cell.new(x, y, state)
          end
        end
      end

      def mark_changes_for_next_generation
        self.each_cell do |cell|
          cell.should_live_in_next_generation =
            Rules.should_cell_live?(self, cell)
        end
      end

      def sweep_changes_for_next_generation!
        self.each_cell { |cell| cell.change_state_if_needed! }
      end

      # Calculates the co-ordinates of neighbors of a given pair of co-ordinates
      # @param [Integer] x the x-coordinate
      # @param [Integer] y the y-coordinate
      # @return [Array<Integer, Integer>] the list of neighboring co-ordinates
      # @example
      #   coords_of_neighbors(1,1) =>
      #     [
      #       [0, 0], [0, 1], [0, 2],
      #       [1, 0],         [1, 2],
      #       [2, 0], [2, 1], [2, 2],
      #     ]
      def coords_of_neighbors(x, y)
        coords_of_neighbors = []
        (x - 1).upto(x + 1).each do |neighbors_x|
          (y - 1).upto(y + 1).each do |neighbors_y|
            next if (x == neighbors_x) && (y == neighbors_y)
            coords_of_neighbors << [neighbors_x, neighbors_y]
          end
        end
        coords_of_neighbors
      end
  end
end
