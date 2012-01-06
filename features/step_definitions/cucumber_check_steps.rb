def game
  @game ||= GameOfLife::Game.new
end

When /^I start a game$/ do
  # Nothing to do
end

Then /^I should see "([^"]*)"$/ do |greeting|
  game.start.should == greeting
end
