require "spec_helper"

module GameOfLife
  describe Game do
    describe "#start" do
      it "should greet the player" do
        GameOfLife::Game.new.start.should == 'Hello GameOfLife player!'
      end
    end
  end
end
