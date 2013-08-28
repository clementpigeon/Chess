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
        p 'row: ', row = attr[:row_options][index]
        p 'col: ', col = attr[:col_options][i]

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
    # [player1, player2].each_with_index do |player, index|
#       8.times do |i|
#         row = index == 0 ? 6 : 1
#         col = i
#
#         new_pawn = Pawn.new(self, player, [row, col])
#         self[row, col] = new_pawn
#         @pieces << new_pawn
#       end
#     end
  end

  def reset_rooks(player1, player2)
    [player1, player2].each_with_index do |player, index|
      2.times do |i|
        row = index == 0 ? 7 : 0
        col = i == 0 ? 0 : 7

        new_rook = Rook.new(self, player, [row, col])
        self[row, col] = new_rook
        @pieces << new_rook
      end
    end
  end

  def reset_bishops(player1, player2)
    [player1, player2].each_with_index do |player, index|
      2.times do |i|
        row = index == 0 ? 7 : 0
        col = i == 0 ? 2 : 5

        new_bishop = Bishop.new(self, player, [row, col])
        self[row, col] = new_bishop
        @pieces << new_bishop
      end
    end
  end

  def reset_knights(player1, player2)
    [player1, player2].each_with_index do |player, index|
      2.times do |i|
        row = index == 0 ? 7 : 0
        col = i == 0 ? 1 : 6

        new_knight = Knight.new(self, player, [row, col])
        self[row, col] = new_knight
        @pieces << new_knight
      end
    end
  end

  def reset_queens(player1, player2)
    [player1, player2].each_with_index do |player, index|
      row = index == 0 ? 7 : 0
      col = 3

      new_queen = Queen.new(self, player, [row, col])
      self[row, col] = new_queen
      @pieces << new_queen
    end
  end

  def reset_kings(player1, player2)
    [player1, player2].each_with_index do |player, index|
      row = index == 0 ? 7 : 0
      col = 4

      new_king = King.new(self, player, [row, col])
      self[row, col] = new_king
      @pieces << new_king
    end
  end
end