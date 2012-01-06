def game
  @game ||= GameOfLife::Game.new(GameOfLife::Outputters::SimpleStringOutputter)
end

Given /^that the game is seeded with:$/ do |raw_input|
  game.seed(raw_input)
end

When /^the next tick occurs$/ do
  game.tick
end

Then /^the board's state should change to:$/ do |expected_formatted_output|
  game.board.view.should == expected_formatted_output
end
