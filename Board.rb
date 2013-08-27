require './board_reset_methods.rb'

class Board

  def initialize
    @board = empty_board
  end

  def pieces_on_board
    #returns a hash {red: [red pieces], blue: [blue pieces]}
    blue_pieces = []
    red_pieces = []
    @board.each do |row|
      row.each do |square|
        unless square.nil?
          blue_pieces << square if square.owner.color == :blue
          red_pieces << square if square.owner.color == :red
        end
      end
    end

    {blue: blue_pieces, red: red_pieces}

  end

  def display
    #puts "board".colorize :red
    puts "   " + ('a'..'h').to_a.join(' ')
    @board.each_with_index do |row, index|
      print 8 - index, " "
      row.each do |square|
        print '|'
        if square.nil?
          print "_"
        else
          print square
        end
      end
      puts "| #{8 - index}"
    end
    puts "   " + ('a'..'h').to_a.join(' ')
  end

  def checkmate?
    false
  end

  def set_square_contents(coord, value)
    @board[coord[0]][coord[1]] = value
  end

  def get_square_contents(coord)
    @board[coord[0]][coord[1]]
  end

  def [](x, y)
    @board[x][y]
  end

  def []=(x, y, value)
    @board[x][y] = value
  end

  def empty_board
    Array.new(8) { Array.new(8) { nil } }
  end
end



