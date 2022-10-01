# frozen_string_literal: true

require_relative '../lib/connect_four'

# Tests for the main Connect4/game logic class

describe ConnectFour do
  # default board size
  subject(:game) { described_class.new }

  context 'when game is initialized with default board size' do
    it 'board has 6 rows' do
      expect(game.board.length).to eql(6)
    end

    it 'row has 7 spaces' do
      expect(game.board[0].length).to eql(7)
    end

    it 'board has only empty spaces' do
      expect(game.board.flatten.all?(nil)).to be true
    end
  end

  context 'when board is updated once' do
    before do
      pos = 3
      symbol = 'A'
      game.update_board(pos, symbol)
    end

    it 'symbol in correct space' do
      expect(game.board[0][pos]).to eql(symbol)
    end

    it 'no other spaces changed' do
      expect(game.board.flatten.compact.length).to eq(1)
    end
  end
end
