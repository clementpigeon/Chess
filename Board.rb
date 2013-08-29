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
          print "_".colorize(background: :light_black)
        else
          print square.to_s.colorize(background: :light_black)
        end
      end
      puts "| #{8 - index}"
    end
    puts "   " + ('a'..'h').to_a.join(' ')
  end

  def checkmate_OLD?(player1, player2)
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

  def checkmate?(player)
    if not rescueable?(player.king)
      return true
    else
      return false
    end
  end

  def rescueable?(king)
 #   debugger
    own_pieces = @pieces.select { |piece| king.owner == piece.owner && piece.location }
    all_rescues = []
    own_pieces.each do |piece|
   #   these_rescues = rescues(king, piece)
      all_rescues += rescues(king, piece)
      p piece, ", ", all_rescues
    end
    if all_rescues.empty?
      return false
    else
      return true
    end

  end

  def rescues(king, piece)
    rescues = piece.valid_destinations
    # rescues.select! do |rescue_move|
   #    piece.valid_move? rescue_move
   #  end

    rescues.reject! do |rescue_move|
      origin_contents = piece.dup
      destination_contents = self[rescue_move[0], rescue_move[1]]
      destination_contents = destination_contents.dup if destination_contents

      piece.owner.make_move(piece, rescue_move)
      result = king.in_check?

      piece.owner.make_move(piece, origin_contents.location)
      self[rescue_move[0], rescue_move[1]] = destination_contents
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

  PIECE_ATTRIBUTES = {
    pawn: {
      type: :Pawn,
      row_options: [6, 1],
      col_options: (0..7).to_a,
      amount: 8
    },
    rook: {
      type: :Rook,
      row_options: [7, 0],
      col_options: [0, 7],
      amount: 2
    },
    knight: {
      type: :Knight,
      row_options: [7, 0],
      col_options: [1, 6],
      amount: 2
    },
    bishop: {
      type: :Bishop,
      row_options: [7, 0],
      col_options: [2, 5],
      amount: 2
    },
    queen: {
      type: :Queen,
      row_options: [7, 0],
      col_options: [3],
      amount: 1
    },
    king: {
      type: :King,
      row_options: [7, 0],
      col_options: [4],
      amount: 1
    }
  }

  def reset_pieces(player1, player2)
    @board = empty_board

    PIECE_ATTRIBUTES.each_value do |attr_hash|
      reset_piece_type(player1, player2, attr_hash)
    end
  end

  def reset_piece_type(player1, player2, attr)

    [player1, player2].each_with_index do |player, index|
      attr[:amount].times do |i|
        row = attr[:row_options][index]
        col = attr[:col_options][i]

        # to turn a symbol into a class
        this_class = Module.const_get(attr[:type])
        new_piece = this_class.new(self, player, [row, col])
        @board[row][col] = new_piece
        @pieces << new_piece
      end
    end
  end
end
