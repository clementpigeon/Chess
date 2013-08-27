class Board
  def reset_pieces(player1, player2)
    @board = self.empty_board
    reset_pawns(player1, player2)
    reset_rooks(player1, player2)
    reset_bishops(player1, player2)
    reset_knights(player1, player2)
    reset_queens(player1, player2)
    reset_kings(player1, player2)
  end

  def reset_pawns(player1, player2)
    (0..7).to_a.each do |i|
      self[6, i] = Piece.new(@board, :pawn, player1, [1, i])
    end

    (0..7).to_a.each do |i|
      self[1, i] = Piece.new(@board, :pawn, player2, [6, i])
    end
  end

  def reset_rooks(player1, player2)
    self[7, 0] = Piece.new(@board, :rook, player1, [7, 0])
    self[7, 7] = Piece.new(@board, :rook, player1, [7, 7])
    self[0, 0] = Piece.new(@board, :rook, player2, [0, 0])
    self[0, 7] = Piece.new(@board, :rook, player2, [0, 7])
  end

  def reset_bishops(player1, player2)
    self[7, 1] = Piece.new(@board, :bishop, player1, [7, 1])
    self[7, 6] = Piece.new(@board, :bishop, player1, [7, 6])
    self[0, 1] = Piece.new(@board, :bishop, player2, [0, 1])
    self[0, 6] = Piece.new(@board, :bishop, player2, [0, 6])
  end

  def reset_knights(player1, player2)
    self[7, 2] = Piece.new(@board, :knight, player1, [7, 2])
    self[7, 5] = Piece.new(@board, :knight, player1, [7, 5])
    self[0, 2] = Piece.new(@board, :knight, player2, [0, 2])
    self[0, 5] = Piece.new(@board, :knight, player2, [0, 5])
  end

  def reset_queens(player1, player2)
    self[7, 3] = Piece.new(@board, :queen, player1, [7, 3])
    self[0, 3] = Piece.new(@board, :queen, player2, [0, 3])
  end

  def reset_kings(player1, player2)
    self[7, 4] = Piece.new(@board, :king, player1, [7, 4])
    self[0, 4] = Piece.new(@board, :king, player2, [0, 4])
  end
end