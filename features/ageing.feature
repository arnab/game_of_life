Feature: Aeging in Game of Life
  In order to observe aeging of cells
  As an observer
  I want to see live cells die after a certian number of generations

  Scenario: A
    Given that the game is seeded with:
    """
	X X
	X X
    """
    When the next tick occurs
    When the next tick occurs
    Then the board's state should change to:
    """
	X X
	X X
    """
    When the next tick occurs
    When the next tick occurs
    When the next tick occurs
    Then the board's state should change to:
    """
	- -
	- -
    """
