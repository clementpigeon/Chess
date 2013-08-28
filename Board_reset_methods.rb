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

  def reset_pawns(player1, player2)
    [player1, player2].each_with_index do |player, index|
      8.times do |i|
        row = index == 0 ? 6 : 1
        col = i

        new_pawn = Pawn.new(self, player, [row, col])
        self[row, col] = new_pawn
        @pieces << new_pawn
      end
    end
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