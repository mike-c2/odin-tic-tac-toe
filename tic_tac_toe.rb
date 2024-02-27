# frozen_string_literal: true

##
# This class represents a Tic Tac Toe game.
class TicTacToe
  GRID_SIZE = 3

  def initialize
    @column_headers = []
    last_column = ('A'.ord + GRID_SIZE - 1).chr

    ('A'..last_column).each do |column_header|
      @column_headers.push(column_header)
    end

    @rows_headers = []

    (1..GRID_SIZE).each do |row_header|
      @rows_headers.push(row_header.to_s)
    end

    new_game
  end

  def new_game
    reset_grid
    reset_valid_choices
  end

  def played?(game_mark, choice)
    choice = choice.upcase
    return false unless @valid_choices.include?(choice)

    @valid_choices.delete(choice)

    column = @column_headers.find_index(choice[0])
    row = @rows_headers.find_index(choice[1])

    @grid[row][column] = game_mark

    true
  end

  def winner?(game_mark)
    check_horizontal_win?(game_mark) ||
      check_vertical_win?(game_mark) ||
      check_down_diagonal_win?(game_mark) ||
      check_up_diagonal_win?(game_mark)
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

    @column_headers.each do |column|
      @rows_headers.each do |row|
        @valid_choices.push(column + row)
      end
    end
  end

  def print_columns
    print "\n   "
    @column_headers.each { |column| print "|  #{column}  " }
    puts '|'
  end

  def print_grid
    horizontal_line = '--'
    (0...GRID_SIZE).each { |_| horizontal_line += '-------' }

    puts horizontal_line

    (0...GRID_SIZE).each do |row|
      print " #{@rows_headers[row]} |"

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

  def enter_choice
    puts "\n#{name} enter your next move:"
    gets.chomp
  end
end

##
# This class runs the actual Tic Tac Toe
# game.
class GameManager
  def initialize(player_one_name, player_two_name)
    @players = []
    @players.push(Player.new(player_one_name, 'X'))
    @players.push(Player.new(player_two_name, 'O'))

    @game = TicTacToe.new
  end

  def play_games
    puts "\nWelcome to this Tic Tac Toe game!\n\n"

    loop do
      play_game

      break unless play_another_game?

      @game.new_game
    end
  end

  def play_game
    current_player = 0

    loop do
      @game.print_game
      enter_player_choice(@players[current_player])

      break if game_over?(@players[current_player])

      current_player = (current_player + 1) % @players.length
    end

    @game.print_game
  end

  def play_another_game?
    puts "\nWould you like to play another game of Tic Tac Toe? Enter 'y' or 'n':"

    loop do
      response = gets.chomp.downcase

      return false if response == 'n'
      return true if response == 'y'

      puts "Your response is not valid, enter either 'y' or 'n':"
    end
  end

  def enter_player_choice(player)
    puts 'Selection entered is not valid. ' until @game.played?(player.game_mark, player.enter_choice)
  end

  def game_over?(player)
    if @game.winner?(player.game_mark)
      puts "\nGame over, #{player.name} has won the game!"
      return true
    end

    unless @game.more_choices_remaining?
      puts "\nGame over, the game is a tie"
      return true
    end

    false
  end
end

# game_manager = GameManager.new('Player 1', 'Player 2')
# game_manager.play_games
