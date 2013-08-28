class Board
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