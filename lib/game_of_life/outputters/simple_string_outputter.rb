module GameOfLife
  # Outputters can display/render a board in a specific way. Some forms of possible outputters:
  #   JSONOutputter would return the board as a JSON object (which can be used by a website for example)
  #   SimpleStringOutputter can be used by tests to verify results
  #   ConsoleOutputter can render it appropriately for a console-application
  module Outputters
    # Renders a board as a simple string, that can be used to inspect it from, say a test
    class SimpleStringOutputter
      # Renders the given board as a simple string. Cells are delimited by spaces and rows by newlnes
      # A live cell is marked 'X' and a dead cell with a '-'
      # @param [GameOfLife::Board] board the given board
      # @return [String] the board rendered as a string
      def render(board)
        board.inspect
      end
    end
  end
end
