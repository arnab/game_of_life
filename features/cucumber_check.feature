Feature: Cucumber check
  In order to setup my project
  As a developer
  I want cucumber to work

Scenario: check cucumber works with a simple piece of code
  When I start a game
  Then I should see "Hello GameOfLife player!"
