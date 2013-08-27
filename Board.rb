
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
    #
  end

  def [](x, y)
    @board[x][y]
  end

  #fix this(see reset pawns)
  def []=(x, y, value)
    @board[x][y] = value
  end

  def empty_board
    Array.new(8) { Array.new(8) { nil } }
  end

  def reset_pieces(player1, player2)
    @board = self.empty_board

    reset_pawns(player1, player2)

  end

  def reset_pawns(player1, player2)
    (0..7).to_a.each do |i|
      #change the below notation back
      self[1, i] = Piece.new(@board, :pawn, player1, [1, i])
    end

    (0..7).to_a.each do |i|
      #change the below notation back
      self[6, i] = Piece.new(@board, :pawn, player2, [6, i])
    end
  end

end



