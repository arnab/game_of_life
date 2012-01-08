module GameOfLife
  class Game
    # the Game Board
    attr_reader :board

    # Takes the formatted input data and seeds the {Board} with it
    # @param [string] formatted_input
    # @example
    #   [
    #     [:dead, :live, :live, :live],
    #     [:live, :live, nil,   :dead]
    #   ]
    def seed(formatted_input)
      @board = Board.new(formatted_input)
    end

    # The event by which the board transitions from the current to the next generation/state.
    # There are three stages in the process:
    # * reformat the board: Each tick can make the neighboring dead cells
    #   (which are not technically in the board now) cells alive. So reformat the board to
    #   add a new row at the top and bottom an a column at the left and right (all dead cells)
    # * mark and sweep for the next generation
    # * shed the dead weight: In stage 1, we added a layer of dead cells around the current board.
    #   If the whole layer is still dead, just remove it as we don't want to keep adding layers of
    #   dead weight on every tick.
    # @see Board#mark_and_sweep_for_next_generation!
    def tick
      @board.reformat_for_next_generation!
      @board.mark_and_sweep_for_next_generation!
      @board.shed_dead_weight!
    end

  end
end
