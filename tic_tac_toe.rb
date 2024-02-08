# frozen_string_literal: true

##
# This class represents a Tic Tac Toe game.
class TicTacToe
end

##
# This class represents a player, whom will
# play the Tic Tac Toe game.
class Player
  attr_accessor :name
  attr_reader :game_mark

  def initialize(name, game_mark)
    @name = name
    @game_mark = game_mark
  end

  # Prompts the player to enter a selection,
  # which is then returned.
  #
  # @return [String] Input entered by the player
  def enter_choice
    puts "#{name} enter your next move:"
    gets.chomp
  end
end

##
# This class runs the actual Tic Tac Toe
# game.
class GameManager
end
