# frozen_string_literal: true

require_relative '../tic_tac_toe'

describe TicTacToe do
  subject(:game) { described_class.new }
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
