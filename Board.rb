
class Board

  def initialize
    @board = self.empty_board
  end

  def display
    #puts "board".colorize :red
    puts "   " + ('a'..'h').to_a.join(' ')
    @board.each_with_index do |row, index|
      print 8 - index, " "
      row.each do |square|
        print '|'
        print "_" if square.nil?
      end
      puts "| #{8 - index}"
    end
    puts "   " + ('a'..'h').to_a.join(' ')
  end

  def checkmate?
    #
  end

  def [](x, y)
    board[x][y]
  end

  def []=(x, y, value)
    board[x][y] = value
  end

  def empty_board
    Array.new(8) { Array.new(8) { nil } }
  end

  def reset_pieces
    @board = self.empty_board
    # ...
  end

end



