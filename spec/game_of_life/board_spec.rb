require "spec_helper"

module GameOfLife
  describe Board do
    let(:game) {
      GameOfLife::Game.new(
        GameOfLife::Inputters::SimpleStringInputter,
        GameOfLife::Outputters::SimpleStringOutputter
        )
    }

    describe "#initialize" do
      it "should raise Error when seed data contains unequal number of fields across rows" do
        seed_data = [
          [:live, :dead], [:live, :dead, :live]
        ]
        expect {
          Board.new(game, seed_data)
          }.to raise_error ArgumentError, /unequal number of columns/i
      end

      it "should raise Error when number of rows do not equal number of columns" do
        seed_data = [
          [:live, :dead, :live],
          [:live, :dead, :live]
        ]
        expect {
          Board.new(game, seed_data)
          }.to raise_error ArgumentError, /number of rows.*!= number of columns/i
        end

      it "should raise Error when not all elements are present (i.e. some are nil)" do
        seed_data = [
          [:live, :dead], [:dead, nil]
        ]
        expect {
          Board.new(game, seed_data)
          }.to raise_error ArgumentError, /not all elements are filled/i
      end

    end

    describe "#cell_at" do
      let(:board) {
        Board.new(game,[
          [ :live, :live ],
          [ :live, :live ],
        ])
      }
      it "should return nil if the coordinates are negative" do
        board.cell_at(-1, -1).should be_nil
      end

      it "should return nil if the coordinates are outside the board" do
        board.cell_at(26, 11).should be_nil
      end
    end

    describe "#neighbors_of" do
      let(:board) {
        Board.new(game,[
          [ :live, :live, :live ],
          [ :live, :live, :live ],
          [ :live, :live, :live ],
        ])
      }

      it "should return 3 neighbors for the cell at (0,0)" do
        cell = Board::Cell.new(0, 0, :live)
        board.neighbors_of(cell).should have(3).items
      end

      it "should return 3 neighbors for the cell at (2,2)" do
        cell = Board::Cell.new(2, 2, :live)
        board.neighbors_of(cell).should have(3).items
      end

      it "should return 5 neighbors for the cell at (1,0)" do
        cell = Board::Cell.new(1, 0, :live)
        board.neighbors_of(cell).should have(5).items
      end

      it "should return 8 neighbors for the cell at (1,1)" do
        cell = Board::Cell.new(1, 1, :live)
        board.neighbors_of(cell).should have(8).items
      end
    end
  end
end
