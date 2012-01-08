module GameOfLife
  # Raised when a {Board} gets into an invalid shape
  class InvalidBoardError < RuntimeError; end;

  # The board used in the game. Holds the {Cell}s.
  class Board

    # The {Cell}s in this board,internally maintained as a 2D Array of {Cell}s.
    # The x-coordinate increases horizontally and is always positive.
    # The y-coordinate increases vertically and is always positive.
    # Internally, the cells are arranged as a 2D array. The first-level Array indexed
    # with the y-coordinates. It contains an Array of {Cell}s, whose position is
    # the x-coordinate.
    # @note Use {#each_cell}, {#each_row} etc. methods to access the cells individually.
    attr_reader :cells

    # Creates the board
    # @param [2D Array<Symbol>] seed_data the data for the {Cell}s in the board, as an 2D array.
    # @example seed_data looks like
    #   the output of SimpleStringInputter#parse
    # @raise [InvalidBoardError] if the seed_data is not in the shape of a square,
    #   or if all elements are not present
    def initialize(seed_data)
      @cells = Array.new(Array.new)
      seed_with!(seed_data)
      begin
        validate
      rescue InvalidBoardError => ex
        # Add the seed_data into the error message, so the caller gets a clue
        raise InvalidBoardError, ex.message + " [seed data was: #{seed_data.inspect}]"
      end
    end

    # @param [OutPutter] the outputter that you want to use. Defaults to {Outputters::SimpleStringOutputter}
    def view(outputter = Outputters::SimpleStringOutputter.new)
      outputter.render(self)
    end

    def each_row(&block)
      @cells.each { |row| yield row }
    end

    def each_row_with_index(&block)
      @cells.each_with_index { |row, i| yield row, i }
    end

    def each_cell(&block)
      @cells.flatten.each { |cell| yield cell }
    end

    # Find the cell at a given pair of co-ordinates. Following Array symantics,
    # this method returns nil if nothing exists at that location or if the
    # location is out of the board. To avoid Array's negative index symantics it
    # returns nill if a negative index is passed.
    # @param [Integer] x the x-coordinate
    # @param [Integer] y the y-coordinate
    # @return [Cell] or nil
    def cell_at(x, y)
      return nil if (x < 0 || y < 0)
      @cells[y][x] if @cells[y]
    end

    # Finds the neighbors of a given {Cell}'s co-ordinates. The neighbors are the eight cells
    # that surround the given one.
    # @param [Integer] x the x-coordinate of the cell you find the neighbors of
    # @param [Integer] y the y-coordinate of the cell you find the neighbors of
    # @return [Array<Cell>]
    def neighbors_of_cell_at(x, y)
      neighbors = coords_of_neighbors(x, y).map { |x, y| self.cell_at(x, y) }
      neighbors.reject {|n| n.nil?}
    end

    # This is the first stage in a Game's #tick.
    # @see Game#tick
    def reformat_for_next_generation!
      # create an array of dead cells and insert it as the first and last row of cells
      dead_cells = (1..@cells.first.size).map { Cell.new }
      # don't forget to deep copy the dead_cells
      @cells.unshift Marshal.load(Marshal.dump(dead_cells))
      @cells.push Marshal.load(Marshal.dump(dead_cells))

      # also insert a dead cell at the left and right of each row
      @cells.each do |row|
        row.unshift Cell.new
        row.push Cell.new
      end

      # validate to see if we broke the board
      validate
    end

    # Goes through each {Cell} and marks it (using {Rules}) to signal it's state for the next
    # generation. This prevents modifying any {Cell} in-place as each generation is a pure
    # function of the previous. Once all {Cell}s are marked, it sweeps across them gets them
    # to change their state if they were marked to.
    # @see #mark_changes_for_next_generation
    # @see #sweep_changes_for_next_generation!
    def mark_and_sweep_for_next_generation!
      mark_changes_for_next_generation
      sweep_changes_for_next_generation!
    end

    # This is the third and last stage in a Game's #tick.
    # @see Game#tick
    def shed_dead_weight!
      # Remove the first and last rows if all cells are dead
      @cells.shift if @cells.first.all? { |cell| cell.dead? }
      @cells.pop if @cells.last.all? { |cell| cell.dead? }

      # Remove the first cell of every row, if they are all dead
      first_columns = @cells.map { |row| row.first }
      if first_columns.all? { |cell| cell.dead? }
        @cells.each { |row| row.shift }
      end

      # Remove the last cell of every row, if they are all dead
      last_columns = @cells.map { |row| row.last }
      if last_columns.all? { |cell| cell.dead? }
        @cells.each { |row| row.pop }
      end

      validate
    end

    private
      def validate
        num_o_rows = @cells.size
        columns_in_each_row = @cells.map(&:size)
        unless columns_in_each_row.uniq.size == 1
          msg = "Unequal number of columns, #{columns_in_each_row.inspect} in different rows found"
          raise InvalidBoardError, msg
        end

        num_o_columns = columns_in_each_row.uniq.first
        num_o_elements = @cells.flatten.reject {|d| d.nil? }.size
        unless (num_o_rows * num_o_columns) == num_o_elements
          msg = "Not a rectangular shape: " +
            "rows(#{num_o_rows}) x columns(#{num_o_columns}) != total elements(#{num_o_elements})]. "
          raise InvalidBoardError, msg
        end
      end

      def seed_with!(data)
        data.each_with_index do |row, y|
          @cells << []
          row.each_with_index do |state, x|
            @cells[y] << Cell.new(state)
          end
        end
      end

      def mark_changes_for_next_generation
        self.each_row_with_index do |cells, y|
          cells.each_with_index do |cell, x|
            cell.should_live_in_next_generation =
              Rules.should_cell_live?(self, cell, x, y)
          end
        end
      end

      def sweep_changes_for_next_generation!
        self.each_cell { |cell| cell.change_state_if_needed! }
      end

      # Calculates the co-ordinates of neighbors of a given pair of co-ordinates.
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
      # @note This method returns all possible co-ordinate pairs of neighbors,
      #   so it can contain coordinates of cells not in the board, or negative ones.
      # @see #neighbors_of_cell_at
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
