# frozen_string_literal: true

# rubocop: disable Metrics/BlockLength

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

  describe '#update_board' do
    context 'when board is updated once' do
      before do
        pos = 3
        symbol = 'A'
        game.update_board(pos, symbol)
      end

      it 'symbol in correct space' do
        expect(game.board[0][3]).to eql('A')
      end

      it 'no other spaces changed' do
        expect(game.board.flatten.compact.length).to eq(1)
      end
    end

    context 'when pieces are stacked' do
      before do
        pos = 3
        game.update_board(pos, 'A')
        game.update_board(pos, 'B')
      end

      it 'first symbol in correct space' do
        expect(game.board[0][3]).to eql('A')
      end

      it 'second symbol in correct space' do
        expect(game.board[1][3]).to eql('B')
      end

      it 'is not game over' do
        expect(game.game_over?).to be false
      end
    end
  end

  describe '#game_over' do
    context 'no victory' do
      before do
        game.update_board(1, 'A')
      end

      it 'is not game over' do
        expect(game.game_over?).to be false
      end
    end

    context 'four mixed symbols' do
      before do
        game.update_board(0, 'A')
        game.update_board(1, 'B')
        game.update_board(2, 'A')
        game.update_board(3, 'B')
      end

      it 'is not game over' do
        expect(game.game_over?).to be false
      end
    end

    context 'horizontal victory' do
      before do
        4.times do |pos|
          game.update_board(pos, 'A')
        end
      end

      it 'is game over' do
        expect(game.game_over?).to be true
        expect(game.horizontal_check).to be true
      end

      it 'no false positives' do
        expect(game.vertical_check).to be false
        expect(game.diagonal_check).to be false
      end
    end

    context 'vertical victory' do
      before do
        4.times do
          game.update_board(1, 'A')
        end
      end

      it 'is game over' do
        expect(game.game_over?).to be true
        expect(game.vertical_check).to be true
      end

      it 'no false positives' do
        expect(game.horizontal_check).to be false
        expect(game.diagonal_check).to be false
      end
    end

    context 'right diagonal victory' do
      before do
        game.update_board(1, 'B')
        2.times { game.update_board(2, 'B') }
        3.times { game.update_board(3, 'B') }

        4.times do |pos|
          game.update_board(pos, 'A')
        end
      end

      it 'is game over' do
        expect(game.game_over?).to be true
        expect(game.right_diagonal_check).to be true
      end

      it 'no false positives' do
        expect(game.vertical_check).to be false
        expect(game.horizontal_check).to be false
        expect(game.left_diagonal_check).to be false
      end
    end

    context 'left diagonal victory' do
      before do
        game.update_board(2, 'B')
        2.times { game.update_board(1, 'B') }
        3.times { game.update_board(0, 'B') }

        4.times do |pos|
          game.update_board(pos, 'A')
        end
      end

      it 'is game over' do
        expect(game.game_over?).to be true
        expect(game.left_diagonal_check).to be true
      end

      it 'no false positives' do
        expect(game.vertical_check).to be false
        expect(game.horizontal_check).to be false
        expect(game.right_diagonal_check).to be false
      end
    end
  end
end
