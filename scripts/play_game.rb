#!/usr/bin/env ruby -KU

$LOAD_PATH << './lib'
require "game_of_life"

game = GameOfLife::Game.new

file_name = ARGV[0]
raise "Please provide a seed file as an argument. See inside the examples directory for examples." unless file_name
raw_input = File.readlines file_name
raw_input = raw_input.map { |line| line.chomp }.join("\n")

formatted_seed_data = GameOfLife::Inputters::SimpleStringInputter.new.parse raw_input
game.seed(formatted_seed_data)

puts "Starting with:"
puts game.board.view

i = 1
while(true)
  print "\e[2J\e[f"
  puts "Generation: #{i}"
  game.tick
  puts game.board.view
  i += 1
  sleep(1)
end
