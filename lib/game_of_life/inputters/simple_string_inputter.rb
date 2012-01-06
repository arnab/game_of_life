module GameOfLife
  # Inputters can parse various kinds of data into a format that is easily converted to {Board}'s {Cell}s. Some forms of possible inputters:
  #   JSONInputter would accept JSON objects (which can be posted by a website for example)
  #   SimpleStringInputter can be used by tests to verify results
  #   FileInputter can read files in a given format
  module Inputters
    # parses an input {String} for the board data
    class SimpleStringInputter
      # Parses board's data from a string.
      # @example Will parse this input string
      #   X - X
      #   - - -
      #   - X -
      # @example into this output structure:
      #   [
      #     [:live, :dead, :live],
      #     [:dead, :dead, :dead],
      #     [:dead, :live, :dead]
      #   ]
      # @param [String] raw_input the given string
      # @return [2D Array<Symbol>] formatted board data
      # @raise [ArgumentError] if anything other then an 'X' or '-' as the state
      def parse(raw_input)
        rows = raw_input.split("\n")
        rows.map! { |row| row.split(' ') }
        rows.map! do |row|
          row.map! { |symbol| convert_cryptic_symbol_to_state(symbol) }
        end
        rows
      end

      private
        def convert_cryptic_symbol_to_state(symbol)
          case symbol
          when 'X'
            :live
          when '-'
            :dead
          else
            raise ArgumentError, "Don't know how to convert #{symbol} into a Cell's state"
          end
        end

    end
  end
end
