require "spec_helper"

module GameOfLife
  describe Board::Cell do
    describe "#initialize" do

      it "should raise Error when an unknown state is given" do
        expect {
          Board::Cell.new(5, 6, :in_limbo)
          }.to raise_error ArgumentError, /in_limbo/
      end

      it "should raise Error when an negative x-coord is given" do
        expect {
          Board::Cell.new(-5, 6, :live)
          }.to raise_error ArgumentError, /x-coordinate/
      end

      it "should raise Error when an negative y-coord is given" do
        expect {
          Board::Cell.new(5, -6, :dead)
          }.to raise_error ArgumentError, /y-coordinate/
      end

    end
  end
end
