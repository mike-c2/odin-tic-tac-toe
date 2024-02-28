# frozen_string_literal: true

require_relative '../tic_tac_toe'

describe TicTacToe do
  subject(:game) { described_class.new }

  describe '#new_game' do
    let(:old_grid) do
      [['X', ' ', 'O'],
       ['O', 'X', ' '],
       ['X', ' ', 'O']]
    end
    let(:old_valid_choices) { %w[B1 C2 B3] }

    let(:new_grid) do
      [[' ', ' ', ' '],
       [' ', ' ', ' '],
       [' ', ' ', ' ']]
    end
    let(:new_valid_choices) { %w[A1 A2 A3 B1 B2 B3 C1 C2 C3] }

    context 'when the game has some plays present on it' do
      before do
        game.instance_variable_set(:@grid, old_grid)
        game.instance_variable_set(:@valid_choices, old_valid_choices)
      end

      it '@grid gets cleared' do
        game.new_game
        grid = game.instance_variable_get(:@grid)

        expect(grid).to eq(new_grid)
      end

      it '@valid_choices gets reset to have all possible choices' do
        game.new_game
        valid_choices = game.instance_variable_get(:@valid_choices)

        expect(valid_choices).to eq(new_valid_choices)
      end
    end
  end

  describe '#played?' do
    let(:game_mark) { 'X' }

    context 'when given a valid input as argument' do
      before do
        valid_choices = %w[A1 A2 A3 B1 B2 B3]
        game.instance_variable_set(:@valid_choices, valid_choices)
      end

      it 'returns true' do
        choice = 'A1'
        expect(game).to be_played(game_mark, choice)
      end
    end

    context 'when given an invalid input as argument' do
      before do
        valid_choices = %w[A2 A3 B1 B2 B3]
        game.instance_variable_set(:@valid_choices, valid_choices)
      end

      it 'returns false' do
        choice = 'A1'
        expect(game).not_to be_played(game_mark, choice)
      end
    end
  end

  describe '#winner?' do
    context 'when there is no winning pattern present' do
      let(:grid) do
        [['X', ' ', 'O'],
         ['O', 'X', ' '],
         [' ', ' ', ' ']]
      end

      before do
        game.instance_variable_set(:@grid, grid)
      end

      it 'returns false' do
        expect(game).not_to be_winner('X')
      end
    end

    context 'when the top row has a winning pattern' do
      let(:grid) do
        [['O', 'O', 'O'],
         ['O', 'X', 'X'],
         ['X', ' ', 'X']]
      end

      before do
        game.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(game).to be_winner('O')
      end
    end

    context 'when the middle row has a winning pattern' do
      let(:grid) do
        [['O', 'O', ' '],
         ['X', 'X', 'X'],
         [' ', ' ', 'O']]
      end

      before do
        game.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(game).to be_winner('X')
      end
    end

    context 'when the bottom row has a winning pattern' do
      let(:grid) do
        [['X', ' ', 'X'],
         ['O', 'X', 'X'],
         ['O', 'O', 'O']]
      end

      before do
        game.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(game).to be_winner('O')
      end
    end

    context 'when the left column has a winning pattern' do
      let(:grid) do
        [['O', ' ', 'X'],
         ['O', 'X', 'X'],
         ['O', 'X', 'O']]
      end

      before do
        game.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(game).to be_winner('O')
      end
    end

    context 'when the middle column has a winning pattern' do
      let(:grid) do
        [['O', 'X', 'X'],
         [' ', 'X', ' '],
         ['O', 'X', 'O']]
      end

      before do
        game.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(game).to be_winner('X')
      end
    end

    context 'when the right column has a winning pattern' do
      let(:grid) do
        [['X', ' ', 'O'],
         ['X', 'X', 'O'],
         ['O', 'X', 'O']]
      end

      before do
        game.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(game).to be_winner('O')
      end
    end

    context 'when the upward diagonal has a winning pattern' do
      let(:grid) do
        [['O', 'O', 'X'],
         [' ', 'X', ' '],
         ['X', 'X', 'O']]
      end

      before do
        game.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(game).to be_winner('X')
      end
    end

    context 'when the downward diagonal has a winning pattern' do
      let(:grid) do
        [['O', ' ', 'X'],
         [' ', 'O', ' '],
         ['X', 'X', 'O']]
      end

      before do
        game.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(game).to be_winner('O')
      end
    end
  end

  describe '#more_choices_remaining?' do
    context 'when there are no choices remaining' do
      let(:no_choices) { [] }

      before do
        game.instance_variable_set(:@valid_choices, no_choices)
      end

      it 'returns false' do
        expect(game).not_to be_more_choices_remaining
      end
    end

    context 'when there are choices remaining' do
      let(:choices) { %w[A1] }

      before do
        game.instance_variable_set(:@valid_choices, choices)
      end

      it 'returns true' do
        expect(game).to be_more_choices_remaining
      end
    end
  end
end
