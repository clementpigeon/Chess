class Player
  attr_accessor :board, :color

  def initialize(board, color)
    @board, @color = board, color
  end

  def get_user_input
    print "Enter move: "
    input = gets.chomp
  end

  # f2, f3
  # e7, e5
  # g2, g4
  # d8, h4

  def parse_input(input)
    # returns [piece, destination]
    locations = input.split(', ')
    origin = parse_coordinate(locations[0])
    destination = parse_coordinate(locations[1])
    [@board.get_square_contents(origin), destination]
    #return [@board[1, 5], [2, 5]]
  end

  def parse_coordinate(string)
    col = ('a'.."h").to_a.index(string[0])
    row = 8 - string[1].to_i
    [row, col]
  end

  def take_turn
    # use get_move to get the to and from coords such as [f8, g7]
    @board.display
    move = parse_input(get_user_input)

    moved_piece = move[0]
    destination = move[1]

    if moved_piece.valid_move? destination
      make_move(moved_piece, destination)
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


end