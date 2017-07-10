'#!/usr/bin/env ruby'
require_relative '../app/models/hangman.rb'
require_relative '../app/models/user.rb'
require_relative '../app/models/word.rb'


game = Hangman.new
game.play_game

