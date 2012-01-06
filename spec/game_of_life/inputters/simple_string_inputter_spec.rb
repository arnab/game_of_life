require "spec_helper"

module GameOfLife
  describe Inputters::SimpleStringInputter do
    describe "#parse" do
      let(:inputter) { GameOfLife::Inputters::SimpleStringInputter.new }
      it "should raise Error when an unknown symbol (other than X or -) is given" do
        str = ["X Y -", "Y Y -"].join("\n")
        expect {
          inputter.parse(str)
          }.to raise_error ArgumentError, /Y/
      end

      it "should not raise Error when X and - are the only symbols used" do
        str = ["X - -", "- X -"].join("\n")
        expect {
          inputter.parse(str)
          }.to_not raise_error ArgumentError
      end

    end
  end
end
