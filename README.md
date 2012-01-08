# Conway's Game of Life, in Ruby
[![Build Status](https://secure.travis-ci.org/arnab/game_of_life.png?branch=master)][travis]
[travis]: http://travis-ci.org/arnab/game_of_life

## About
See the [notes file](https://github.com/arnab/game_of_life/blob/master/notes.md) for details about my thoughts.

## Setup
* If you are using rvm, as soon as you cd into this directory a gemset will be created, wherein all the gems will be installed by bundler
* So the only steps you need to take are:
	1. `gem install bundler`
	2. `bundle install`

## How to play
* Run the cucumber steps to see examples.
* You can play with the code with the simple script provided:
`
./scripts/play_game.rb examples/pulsar.txt
`

## Documentation
### Hosted
* Available at [http://rubydoc.info/github/arnab/game_of_life/](http://rubydoc.info/github/arnab/game_of_life/)

### Build your own
* Follow setup steps above if you have not already
* Generate the yard dpcumentation by running: `yard server --reload`
* Then you can see it at http://localhost:8808/

## Supported Rubies
[Tested against][travis] the following Ruby implementations:

* Ruby 1.8.7
* Ruby 1.9.2
* Ruby 1.9.3
* [JRuby][]
* [Rubinius][]
* [Ruby Enterprise Edition][ree]

[jruby]: http://www.jruby.org/
[rubinius]: http://rubini.us/
[ree]: http://www.rubyenterpriseedition.com/

##Copyright
Copyright (c) 2012 Arnab Deka.
See [LICENSE][] for details.

[license]: https://github.com/arnab/game_of_life/blob/master/LICENSE.md

