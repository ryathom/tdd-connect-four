# frozen_string_literal: true

require_relative '../lib/player'

# Tests for the Connect4 player class

describe Player do
  subject(:player) { described_class.new('Ryan', 'A', 7) }

  describe '#verify_input' do
    it 'when user gives valid input' do
      expect(player.verify_input(3)).to eql(3)
    end

    it 'when user gives number outside valid range' do
      expect(player.verify_input(9)).to eql(nil)
    end

    it 'when user gives a letter' do
      expect(player.verify_input('A')).to eql(nil)
    end

    it 'when user gives a symbol' do
      expect(player.verify_input('!')).to eql(nil)
    end
  end

  describe '#player_input' do
    context 'when player gives valid input' do
      before do
        valid_input = '3'
        allow(player).to receive(:gets).and_return(valid_input)
      end

      it 'stops loop and does not display error message' do
        max = 6
        error_message = "Input error! Please enter a number between 0 and #{max}."
        expect(player).not_to receive(:puts).with(error_message)
        player.player_input
      end
    end

    context 'when player gives invalid input (letter), followed by valid' do
      before do
        valid_input = '4'
        invalid_input = 'B'
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'shows error message once, then stops loop' do
        max = 6
        error_message = "Input error! Please enter a number between 0 and #{max}."

        expect(player).to receive(:puts).with(error_message)
        expect(player).not_to receive(:puts).with(error_message)

        player.player_input
      end
    end

    context 'when player gives invalid input (number), followed by valid' do
      before do
        valid_input = '4'
        invalid_input = '9'
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'shows error message once, then stops loop' do
        max = 6
        error_message = "Input error! Please enter a number between 0 and #{max}."

        expect(player).to receive(:puts).with(error_message)
        expect(player).not_to receive(:puts).with(error_message)

        player.player_input
      end
    end

    context 'when player gives two invalid inputs, followed by valid' do
      before do
        valid_input = '5'
        invalid_number = '11'
        invalid_symbol = '!'
        allow(player).to receive(:gets).and_return(invalid_number, invalid_symbol, valid_input)
      end

      it 'shows error message twice, then stops loop' do
        max = 6
        error_message = "Input error! Please enter a number between 0 and #{max}."

        expect(player).to receive(:puts).with(error_message).twice
        expect(player).not_to receive(:puts).with(error_message)

        player.player_input
      end
    end
  end
end
