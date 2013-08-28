require './board_reset_methods.rb'

class Board

  attr_accessor :pieces

  def initialize
    @board = empty_board
    @pieces = []
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

  def checkmate?(player1, player2)
    both_kings = @pieces.select { |piece| piece.is_a?(King) }
    player1_king = both_kings.select { |piece| piece.owner.color == :blue }[0]
    player2_king = both_kings.select { |piece| piece.owner.color == :red }[0]

    kings = [player1_king, player2_king]

    kings.each do |king|
      if king.in_check?
        return true unless rescueable?(king)
      end
    end
    false
  end

  def rescueable?(king)
    own_pieces = @pieces.select { |piece| king.owner == piece.owner }

    own_pieces.each do |piece|
      rescues = rescues(king, piece)
      return true unless rescues.empty?
    end

    false
  end

  def rescues(king, piece)
    rescues = piece.possible_destinations
    rescues.select! do |rescue_move|
      piece.valid_move? rescue_move
    end

    rescues.reject! do |rescue_move|
      original_location = piece.location

      if @board[rescue_move[0]][rescue_move[1]]
        rescue_content = @board[rescue_move[0]][rescue_move[1]].dup
      end

      piece.owner.make_move(piece, rescue_move)
      result = king.in_check?

      piece.owner.make_move(piece, original_location)


      if self[rescue_move[0], rescue_move[1]]
        self[rescue_move[0], rescue_move[1]] = rescue_content
      end

      result
    end

    rescues
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



