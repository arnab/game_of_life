require "spec_helper"

module GameOfLife
  describe Board do
    describe "#initialize" do
      let(:game) {
        GameOfLife::Game.new(
          GameOfLife::Inputters::SimpleStringInputter,
          GameOfLife::Outputters::SimpleStringOutputter
          )
      }

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
  end
end
