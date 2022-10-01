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
end
