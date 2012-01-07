Feature: Gameplay of the Game of Life
  In order to observe the Game of Life being played out
  As an observer
  I want various scenarios of the game to change the state of the board correctly

  Scenario: A: Block pattern
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

  Scenario: B: Boat pattern
    Given that the game is seeded with:
    """
    X X -
    X - X
    - X -
    """
    When the next tick occurs
    Then the board's state should change to:
    """
    X X -
    X - X
    - X -
    """

  Scenario: C: Blinker pattern
    Given that the game is seeded with:
    """
    - X -
    - X -
    - X -
    """
    When the next tick occurs
    Then the board's state should change to:
    """
    - - -
    X X X
    - - -
    """

@wip
  Scenario: D: Toad pattern
    Given that the game is seeded with:
    """
    - X X X
    X X X -
    """
    When the next tick occurs
    Then the board's state should change to:
    """
    - - X -
    X - - X
    X - - X
    - X - -
    """
