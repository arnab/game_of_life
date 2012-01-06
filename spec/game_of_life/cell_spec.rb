require "spec_helper"

module GameOfLife
  describe Board::Cell do
    describe "#initialize" do

      it "should raise Error when an unknown state is given" do
        expect {
          Board::Cell.new(:in_limbo, 5, 6)
          }.to raise_error ArgumentError, /in_limbo/
      end

      it "should raise Error when an negative x-coord is given" do
        expect {
          Board::Cell.new(:live, -5, 6)
          }.to raise_error ArgumentError, /x-coordinate/
      end

      it "should raise Error when an negative y-coord is given" do
        expect {
          Board::Cell.new(:dead, 5, -6)
          }.to raise_error ArgumentError, /y-coordinate/
      end

    end
  end
end
