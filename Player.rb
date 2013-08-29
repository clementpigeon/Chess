COMPUTER_PLAYER = false

class Player
  attr_accessor :board, :color

  def initialize(board, color)
    @board, @color = board, color
  end

  def get_user_input
    if !COMPUTER_PLAYER
      print "Enter move: ".colorize (@color)
      input = gets.chomp
    else
      letter1 = ('a'..'h').to_a.sample
      letter2 = ('a'..'h').to_a.sample
      number1 = ('1'..'8').to_a.sample
      number2 = ('1'..'8').to_a.sample

      letter1 + number1 + ' ' + letter2 + number2
    end
  end

  def parse_input(input)
    locations = input.split(' ')
    origin = parse_coordinate(locations[0])
    destination = parse_coordinate(locations[1])
    [@board.get_square_contents(origin), destination]
    #return [piece, destination]
  end

  def parse_coordinate(string)
    col = ('a'.."h").to_a.index(string[0])
    row = 8 - string[1].to_i
    [row, col]
  end

  def take_turn
    # use get_move to get the to and from coords such as [f8, g7]
    move = parse_input(get_user_input)

    moved_piece = move[0]
    destination = move[1]

    if moved_piece.nil?
      puts "No piece at that location. Try again" unless COMPUTER_PLAYER
      return take_turn
    elsif moved_piece.owner != self
      puts "Can't move opponent piece. Try again" unless COMPUTER_PLAYER
      return take_turn
    elsif not moved_piece.valid_destinations.include?(destination)
      puts "Invalid move. Try again" unless COMPUTER_PLAYER
      return take_turn
    elsif moved_piece.moving_into_check?(destination)
      puts "Can't move into check"
      return take_turn
    else
      puts "grats on moving #{moved_piece.class} to #{destination}"
      make_move(moved_piece, destination)
    end
  end

  def make_move(moved_piece, destination)
    @board.set_square_contents(moved_piece.location, nil)

    moved_piece.location = destination

    destination_square_content = @board.get_square_contents(destination)
    destination_square_content.location = nil if destination_square_content

    @board.set_square_contents(destination, moved_piece)

  end

  def in_check?
    king.in_check?
  end

  def king
    both_kings = @board.pieces.select { |piece| piece.class == King }
    my_king = both_kings.select { |king| king.owner.color == @color }[0]
  end

end