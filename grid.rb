# Grid class generate initial positions for ships in map game
class Grid
  @header = ['\-/', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']
  @rows = ['', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  def initialize
    @grid = initial_grid
    @ships = [(1..6),
              (1..4),
              (1..4),
              (1..3),
              (1..3),
              (1..3),
              (1..2),
              (1..2),
              (1..2)]
  end

  class << self
    attr_reader :header, :rows
  end

  def initial_grid
    grid = []
    (1..10).each { |row| (1..10).each { |col| grid.push "#{row}:#{col}" } }
    grid
  end

  def print_coords(coords, orientation, position)
    coords = coords.split(':')
    row = coords.first
    column = coords.last
    orientation == 'v' ? "#{row}:#{column.to_i + position}" : "#{row.to_i + position}:#{column}"
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

  def position(ship, orientation)
    valid = false
    begin
      coords = ship_range(ship, orientation)
      valid = available_grid?(ship, coords, orientation)
    end until valid
    coords
  end

  def ships_positions
    ship_positions = []
    ship_counter = 1
    @ships.each do |ship|
      battle_position = []
      orientation = [true, false].sample ? 'v' : 'h'
      coords = position(ship, orientation)
      battle_position, @grid = load(battle_position, ship, coords, orientation, ship_counter)
      ship_counter += 1
      ship_positions += battle_position
    end
    ship_positions
  end
end
