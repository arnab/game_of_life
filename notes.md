These are basically just my raw thoughts about the game. See my updates from 1/7 Saturday.

# Objects

## GameOfLife
Top level namespace (module). Has the following things:

### Game
* incorporates rules
* gets the input (*seed*)
* and waits for *tick*s

### Board
* has a grid (2d array) of Cells
* checks integrety after every tick, like:
  - is it a filled shape (orthogonal square)?  
  - we don't do any bounds check as we try not to have our API dictate the client to pass in a bound and then data
  - as long as the board's shape is good and every cell is filled, we are fine

#### Cell
* x, y - coordinates (positive integers)
* state: :live or :dead
  - do we need a state machine or is a simple [:live, :dead].cycle enough for now?
* guards against out of bound type of problems

### Rules
* Any live cell with fewer than two live neighbours dies, as if by loneliness.
* Any live cell with more than three live neighbours dies, as if by overcrowding.
* Any live cell with two or three live neighbours lives, unchanged, to the next generation.
* Any dead cell with exactly three live neighbours comes to life.

### Player
* do we need one? there isn't really a real player, but we can assume one which seeds and then observes the Game#ticks *

# Analysis
Space-complexity wise an infinite grid might be tricky because each tick results in a board which is a pure function of the previous state of the board. In other words, if it's really infinite, or very large, it will be impossible to copy the board before every manipulation. Three options that I can see (following discussions assume there are (n x n) *Cell*s in the *Board*):

* Mark-And-Sweep: Keep some sort of a has\_changed signifier in each *Cell*. Instead of trying to change the state in-place, flip this boolean field. After all the *Cell*s have been touched, use this field to go through once more and flip the state if required.
  - This increases by the space required by O(n-squared * some-constant-amount-for-a-boolean), which is O(n-squared)
* Another simple optimization can be to go row-by-row. Every time we reach row n, where n > 2, th (n-2)th row can be flushed (i.e. their state can be changed) since no *Cell* in (n-2) row can be n row's neighbor. This way only 2 rows need to copied in memory at a time.
  - This increases the space required by O(n). But if n is agan very large (and not n-squared) this will still not be efficient.
* A third approach could be to walk the *Board* in a radially outward manner, flushing the earliest-seen-*Cell*s as soon as we are in a neighborhood which is one row/column away from the first generation.
  - This would be very optimal but will be complicated to write. Is it worth it is the question.

## Assumptions and Conslusions
Given all these considerations and reassurance from my recruiter that we are looking for a *simple* OO Design I am not going with alternative 1: mark and sweep (instead of duplicating the data on every tick).

# Updates
## 1/7 Saturday
So it turns out some of my assumptions were wrong. Given the `X` and `-` markings in the example for live and dead cells I thought that once seeded the size of th board was constant. It dawns on me now that that the "infiniteness" of the board plays on every tick/generation change. Basically, `X` are live cells but everything else (in all directions) is dead (the ones inside the playing area are marked explicity with a `-`). So we'll need some changes, but that's why software is designed with principles of design in mind. Let's see how our code adpats.

I am going to continue and complete the mark-and-sweep part. That will get scenario C passing. To tackle Scenario D (Toad, which changes the size of the board) as the first pas, we can implement the  [self-constructing pattern][1], basically create a new geneation of cells and kill the old one. I suspect it won't perform optimally (given we are using a 2D array) but we can leave the optimization for later (perhaps a 2D LinkedList will fare better).

[1]: http://en.wikipedia.org/wiki/Conway's_Game_of_Life#Self-replication
