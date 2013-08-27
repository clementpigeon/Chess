  def diagonal_destinations
    result = []

    (0..7).to_a.each_index do |i|
      result << [i, @location[1]]
      result << [@location[0], i]
    end

    current_location == self.location
    while current_location.all? < 8 && current_location.all? >= 0 && free == true
      current_location[0] += 1
      current_location[0] += 1
      result << [@location[0], i]
      free = false if get_square_contents(current_location)
    end

    current_location == self.location
    while current_location.all? < 8 && current_location.all? >= 0 && free == true
      current_location[0] += 1
      current_location[0] -= 1
      result << [@location[0], i]
      free = false if get_square_contents(current_location)
    end

    current_location == self.location
    while current_location.all? < 8 && current_location.all? >= 0 && free == true
      current_location[0] -= 1
      current_location[0] += 1
      result << [@location[0], i]
      free = false if get_square_contents(current_location)
    end

    current_location == self.location
    while current_location.all? < 8 && current_location.all? >= 0 && free == true
      current_location[0] -= 1
      current_location[0] -= 1
      result << [@location[0], i]
      free = false if get_square_contents(current_location)
    end
  end



