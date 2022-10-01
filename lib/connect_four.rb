# frozen_string_literal: true

require_relative 'player'

# Main board + game logic class
class ConnectFour
  attr_reader :board

  def initialize(rows = 6, cols = 7)
    @board = initialize_board(rows, cols)
  end

  def initialize_board(rows, cols)
    Array.new(rows) { Array.new(cols, nil) }
  end

  def visualize_board
    idx = @board.length - 1
    until idx.negative?
      p @board[idx]
      idx -= 1
    end
  end

  def update_board(pos, symbol)
    @board.each do |row|
      if row[pos].nil?
        row[pos] = symbol
        break
      end
    end
  end

  def game_over?
    horizontal_check || vertical_check || diagonal_check
  end

  def horizontal_check
    height = @board.length
    width = @board.length

    # check every row, n-3 columns
    height.times do |row|
      (width - 3).times do |col|
        next if @board[row][col].nil?

        sym = @board[row][col]
        return true if (@board[row][col + 1] == sym) && (@board[row][col + 2] == sym) && (@board[row][col + 3] == sym)
      end
    end
    false
  end

  def vertical_check
    height = @board.length
    width = @board.length

    # check every column, n-3 rows
    width.times do |col|
      (height - 3).times do |row|
        next if @board[row][col].nil?

        sym = @board[row][col]
        return true if (@board[row + 1][col] == sym) && (@board[row + 2][col] == sym) && (@board[row + 3][col] == sym)
      end
    end
    false
  end

  def diagonal_check
    left_diagonal_check || right_diagonal_check
  end

  def right_diagonal_check
    height = @board.length
    width = @board.length

    # check n-3 column, n-3 rows
    (width - 3).times do |col|
      (height - 3).times do |row|
        next if @board[row][col].nil?

        sym = @board[row][col]
        if (@board[row + 1][col + 1] == sym) && (@board[row + 2][col + 2] == sym) && (@board[row + 3][col + 3] == sym)
          return true
        end
      end
    end
    false
  end

  def left_diagonal_check
    height = @board.length
    width = @board.length

    # check n-3 column, n-3 rows
    (width - 3).times do |col|
      (height - 3).times do |row|
        row += 3 # testing top n rows
        next if @board[row][col].nil?

        sym = @board[row][col]
        if (@board[row - 1][col + 1] == sym) && (@board[row - 2][col + 2] == sym) && (@board[row - 3][col + 3] == sym)
          return true
        end
      end
    end
    false
  end
end
