require "spec_helper"

module GameOfLife
  describe Board::Cell do
    describe "#initialize" do
      it "should raise Error when an unknown state is given" do
        expect {
          Board::Cell.new(:in_limbo)
          }.to raise_error ArgumentError, /in_limbo/
      end
    end
  end
end
