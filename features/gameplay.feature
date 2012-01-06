Feature: Gameplay of the Game of Life
  In order to observe the Game of Life being played out
  As an observer
  I want various scenarios of the game to change the state of the board correctly

Scenario: Block pattern
  Given that the game is seeded with:
  """
  X X
  X X
  """
  When the next tick occurs
  Then the board's state should change to:
  """
  X X
  X X
  """
