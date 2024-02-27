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

  let(:game_mark) { 'X' }

  describe '#played?' do
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
end
