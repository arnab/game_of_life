def game
  @game ||= GameOfLife::Game.new
end

Given /^that the game is seeded with:$/ do |raw_input|
  formatted_seed_data = GameOfLife::Inputters::SimpleStringInputter.new.parse raw_input
  game.seed(formatted_seed_data)
end

When /^the next tick occurs$/ do
  game.tick
end

Then /^the board's state should change to:$/ do |expected_formatted_output|
  game.board.view.should == expected_formatted_output
end
