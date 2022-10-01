# frozen_string_literal: true

require_relative 'player'

# Main board + game logic class
class ConnectFour
  attr_reader :board

  def initialize(rows = 6, cols = 7)
    @board = initialize_board(rows, cols)
    @height = rows
    @width = cols
  end

  def initialize_board(rows, cols)
    Array.new(rows) { Array.new(cols, nil) }
  end

  def visualize_board
    clear_screen
    idx = @height - 1
    until idx.negative?
      row = @board[idx]
      visible_row = '|'
      row.each do |c|
        if c.nil?
          visible_row += '_'
        else
          visible_row += c 
        end
        visible_row += '|'
      end
      puts visible_row
      idx -= 1
    end
    puts ' 0 1 2 3 4 5 6 '
    puts nil
  end

  def clear_screen
    system 'clear'
  end

  def main
    register_players
    visualize_board

    id = 1
    until game_over?
      (id == 1) ? id = 0 : id = 1
      pos = @players[id].player_input
      update_board(pos, @players[id].symbol)
      visualize_board
    end

    victor = @players[id].name
    puts "#{victor} is the winner!"
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
    # check every row, n-3 columns
    @height.times do |row|
      (@width - 3).times do |col|
        next if @board[row][col].nil?

        sym = @board[row][col]
        return true if (@board[row][col + 1] == sym) && (@board[row][col + 2] == sym) && (@board[row][col + 3] == sym)
      end
    end
    false
  end

  def vertical_check
    # check every column, n-3 rows
    @width.times do |col|
      (@height - 3).times do |row|
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
    # check n-3 column, n-3 rows
    (@width - 3).times do |col|
      (@height - 3).times do |row|
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
    # check n-3 column, n-3 rows
    (@width - 3).times do |col|
      (@height - 3).times do |row|
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

  def register_players
    @players = []

    2.times do |i|
      name = register_name(i+1)
      symbol = register_symbol(i+1)
      @players << Player.new(name, symbol, @board[0].length)
    end
  end

  def register_name(id)
    puts "Player #{id}, enter your name:"
    gets.chomp
  end

  def register_symbol(id)
    puts "Player #{id}, enter a letter or symbol to use as your game piece:"
    loop do
      symbol = gets.chomp
      return symbol if symbol.length == 1
      puts "Input error! Choose a single letter or symbol:"
    end
  end
end
