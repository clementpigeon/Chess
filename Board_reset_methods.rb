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
    players = [player1, player2]

    players.each_with_index do |player, index|

      (0..7).to_a.each do |i|
        row = index == 0 ? 6 : 1
        col = i
        new_pawn = Pawn.new(self, player, [row, col])
        self[row, col] = new_pawn
        @pieces << new_pawn
      end

      # (0..7).to_a.each do |i|
      #   new_pawn = Pawn.new(self, player2, [1, i])
      #   self[1, i] = new_pawn
      #   @pieces << new_pawn
      # end
    end

  end

  def reset_rooks(player1, player2)
    new_pawn = Rook.new(self, player1, [7, 0])
    self[7, 0] = new_pawn
    @pieces << new_pawn
    new_pawn = Rook.new(self, player1, [7, 7])
    self[7, 7] = new_pawn
    @pieces << new_pawn
    new_pawn = Rook.new(self, player2, [0, 0])
    self[0, 0] = new_pawn
    @pieces << new_pawn
    new_pawn = Rook.new(self, player2, [0, 7])
    self[0, 7] = new_pawn
    @pieces << new_pawn
  end

  def reset_bishops(player1, player2)
    new_pawn = Bishop.new(self, player1, [7, 2])
    self[7, 2] = new_pawn
    @pieces << new_pawn
    new_pawn = Bishop.new(self, player1, [7, 5])
    self[7, 5] = new_pawn
    @pieces << new_pawn
    new_pawn = Bishop.new(self, player2, [0, 2])
    self[0, 2] = new_pawn
    @pieces << new_pawn
    new_pawn = Bishop.new(self, player2, [0, 5])
    self[0, 5] = new_pawn
    @pieces << new_pawn
  end

  def reset_knights(player1, player2)
    new_pawn = Knight.new(self, player1, [7, 1])
    self[7, 1] = new_pawn
    @pieces << new_pawn
    new_pawn = Knight.new(self, player1, [7, 6])
    self[7, 6] = new_pawn
    @pieces << new_pawn
    new_pawn = Knight.new(self, player2, [0, 1])
    self[0, 1] = new_pawn
    @pieces << new_pawn
    new_pawn = Knight.new(self, player2, [0, 6])
    self[0, 6] = new_pawn
    @pieces << new_pawn
  end

  def reset_queens(player1, player2)
    new_pawn = Queen.new(self, player1, [7, 3])
    self[7, 3] = new_pawn
    @pieces << new_pawn
    new_pawn = Queen.new(self, player2, [0, 3])
    self[0, 3] = new_pawn
    @pieces << new_pawn
  end

  def reset_kings(player1, player2)
    new_pawn = King.new(self, player1, [7, 4])
    self[7, 4] = new_pawn
    @pieces << new_pawn
    new_pawn = King.new(self, player2, [0, 4])
    self[0, 4] = new_pawn
    @pieces << new_pawn
  end
end