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

  def check_winner?(game_token)
    check_horizontal_win?(game_token) ||
      check_vertical_win?(game_token) ||
      check_down_diagonal_win?(game_token) ||
      check_up_diagonal_win?(game_token)
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

  def check_horizontal_win?(game_mark)
    (0...GRID_SIZE).each do |row|
      return true if @grid[row].count(game_mark) == GRID_SIZE
    end

    false
  end

  def check_vertical_win?(game_mark)
    (0...GRID_SIZE).each do |column|
      is_win = true

      (0...GRID_SIZE).each do |row|
        is_win = false unless @grid[row][column] == game_mark
      end

      return true if is_win
    end

    false
  end

  # Checking from top-left to the bottom-right on grid
  def check_down_diagonal_win?(game_mark)
    (0...GRID_SIZE).each do |index|
      return false unless @grid[index][index] == game_mark
    end

    true
  end

  # Checking from bottom-left to the top-right on grid
  def check_up_diagonal_win?(game_mark)
    (0...GRID_SIZE).each do |index|
      return false unless @grid[index][GRID_SIZE - index - 1] == game_mark
    end

    true
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
