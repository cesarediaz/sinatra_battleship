class Grid
  def initialize
    @grid = initial_grid
    @ships = [(1..6), (1..4), (1..4), (1..3), (1..3), (1..3), (1..2), (1..2), (1..2)]
  end

  def initial_grid
    grid = []
    (1..10).each do |row|
      (1..10).each do |col|
        grid.push "#{row}:#{col}"
      end
    end
    grid
  end

  def print_coords(coords, orientation, position)
    coords = coords.split(':')
    if orientation == 'v'
      "#{coords.first}:#{coords.last.to_i + position}"
    else
      "#{coords.first.to_i + position}:#{coords.last}"
    end
  end

  def available_grid?(ship, coords, orientation)
    unless @grid.empty?
      ship.each do |position|
        return false unless @grid.include?(print_coords(coords, orientation, position))
      end
    end
    true
  end

  def ship_range(ship, orientation)
    valid = false
    array = [*1..10]
    begin
      row = array.sample
      column = array.sample
      if orientation == 'v' && (row + ship.size <= 10)
        coords = "#{column}:#{row}"
        valid = true
      elsif column + ship.size <= 10
        coords = "#{column}:#{row}"
        valid = true
      end
    end until valid
    coords
  end

  def load(battle_positions, ship, coords, orientation, ship_index)
    ship.each do |position|
      battle_positions.push [ship_index, print_coords(coords, orientation, position)]
      @grid.delete print_coords(coords, orientation, position)
    end
    return battle_positions, @grid
  end

  def ships_positions
    ship_positions = []
    ship_counter = 1
    @ships.each do |ship|
      battle_positions = []
      orientation = [true, false].sample ? 'v' : 'h'
      valid = false

      begin
        coords = ship_range(ship, orientation)
        valid = available_grid?(ship, coords, orientation)
      end until valid
      battle_positions, @grid = load(battle_positions, ship, coords, orientation, ship_counter)
      ship_counter += 1
      ship_positions += battle_positions
    end
    ship_positions
  end
end
