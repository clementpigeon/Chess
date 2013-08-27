class Player
  attr_accessor :board, :color

  def initialize(board, color)
    @board, @color = board, color
  end

  def get_user_input

  end

  def take_turn
    # use get_move to get the to and from coords such as [f8, g7]
    move = parse_input(get_user_input)

    moved_piece = move[0]
    destination = move[1]

    if moved_piece.valid_move? destination
      make_move(moved_piece, destination
    else
      puts "try again"
      take_turn
    end
  end

  def make_move(moved_piece, destination)
    @board.set_square_contents(moved_piece.location, nil)

    moved_piece.location = destination

    @board.set_square_contents(destination, moved_piece)
  end

  def illegal
  end

  def parse_input(string)
    # returns [piece, destination]
    return [@board[1, 5], [2, 5]]
  end
end