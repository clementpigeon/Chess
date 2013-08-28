class Board
  def reset_pieces(player1, player2)
    @board = empty_board
    reset_pawns(player1, player2)
    reset_rooks(player1, player2)
    reset_bishops(player1, player2)
    reset_knights(player1, player2)
    reset_queens(player1, player2)
    reset_kings(player1, player2)
  end

  def reset_piece_type(player1, player2, attr)

    [player1, player2].each_with_index do |player, index|
      attr[:amount].times do |i|
        row = attr[:row_options][index]
        col = attr[:col_options][i]

        new_piece = attr[:type].new(self, player, [row, col])
        @board[row][col] = new_piece
        @pieces << new_piece
      end
    end
  end

  def reset_pawns(player1, player2)
    pawn_attributes = {
      type: Pawn,
      row_options: [6, 1],
      col_options: (0..7).to_a,
      amount: 8
    }

    reset_piece_type(player1, player2, pawn_attributes)
  end

  def reset_rooks(player1, player2)
    rook_attributes = {
      type: Rook,
      row_options: [7, 0],
      col_options: [0, 7],
      amount: 2
    }

    reset_piece_type(player1, player2, rook_attributes)
  end

  def reset_bishops(player1, player2)
    bishop_attributes = {
      type: Bishop,
      row_options: [7, 0],
      col_options: [2, 5],
      amount: 2
    }

    reset_piece_type(player1, player2, bishop_attributes)
  end

  def reset_knights(player1, player2)
    knight_attributes = {
      type: Knight,
      row_options: [7, 0],
      col_options: [1, 6],
      amount: 2
    }

    reset_piece_type(player1, player2, knight_attributes)
  end

  def reset_queens(player1, player2)
    queen_attributes = {
      type: Queen,
      row_options: [7, 0],
      col_options: [3],
      amount: 1
    }

    reset_piece_type(player1, player2, queen_attributes)
  end

  def reset_kings(player1, player2)
    king_attributes = {
      type: King,
      row_options: [7, 0],
      col_options: [4],
      amount: 1
    }

    reset_piece_type(player1, player2, king_attributes)
  end
end