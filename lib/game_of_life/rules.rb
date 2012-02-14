module GameOfLife
  module Rules

    # The rules followed are:
    # 1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
    # 2. Any live cell with two or three live neighbours lives on to the next generation.
    # 3. Any live cell with more than three live neighbours dies, as if by overcrowding.
    # 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    # 5. Any live cell that is over 3 generations dies
    def should_cell_live?(board, cell, x, y)
      live_neighbors_count = board.neighbors_of_cell_at(x, y).select { |n| n.alive? }.size
      case cell.state
      when :live
        ((2..3).include? live_neighbors_count) && (! cell.old?)
      when :dead
        live_neighbors_count == 3
      end
    end

    module_function :should_cell_live?
  end
end
