# frozen_string_literal: true

##
# This class represents a Tic Tac Toe game.
class TicTacToe
  GRID_SIZE = 3

  def initialize
    @columns = []
    last_column = ('A'.ord + GRID_SIZE - 1).chr

    ('A'..last_column).each do |column|
      @columns.push(column)
    end

    @rows = []

    (1..GRID_SIZE).each do |row|
      @rows.push(row.to_s)
    end

    new_game
  end

  def new_game
    reset_grid
    reset_valid_choices
  end

  def play?(game_mark, choice)
    choice = choice.upcase
    return false unless @valid_choices.include?(choice)

    @valid_choices.delete(choice)

    column = @columns.find_index(choice[0])
    row = @rows.find_index(choice[1])

    @grid[row][column] = game_mark

    true
  end

  def more_choices_remaining?
    !@valid_choices.empty?
  end

  def print_game
    print_columns
    print_grid
  end

  private

  def reset_grid
    @grid = Array.new(GRID_SIZE) { Array.new(GRID_SIZE, ' ') }
  end

  def reset_valid_choices
    @valid_choices = []

    @columns.each do |column|
      @rows.each do |row|
        @valid_choices.push(column + row)
      end
    end
  end

  def print_columns
    print '   '
    @columns.each { |column| print "|  #{column}  " }
    puts '|'
  end

  def print_grid
    horizontal_line = '--'
    (0...GRID_SIZE).each { |_| horizontal_line += '-------' }

    puts horizontal_line

    (0...GRID_SIZE).each do |row|
      print " #{@rows[row]} |"

      (0...GRID_SIZE).each do |column|
        print "  #{@grid[row][column]}  |"
      end

      puts "\n#{horizontal_line}"
    end
  end
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

mike = TicTacToe.new

10.times do
  puts 'Enter something'
  choice = gets.chomp
  puts mike.play?('X', choice)
  mike.print_game
end
