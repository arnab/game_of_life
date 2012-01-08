# About
See the ***notes*** file for details about my thoughts.

# Setup
* If you are using rvm, as soon as you cd into this directory a gemset will be created, wherein all the gems will be installed by bundler
* So the only steps you need to take are:
	1. `gem install bundler`
	2. `bundle install`

# How to play
* Run the cucumber steps to see examples.
* You can play with the code with the simple script provided:
`
./scripts/play_game.rb examples/pulsar.txt
`

# Documentation
* Generate the yar dpcumentation by running: `yard server --reload` (you need to follow the setup before this).
* Then you can see it at http://localhost:8808/
