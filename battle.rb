class Battle
  def shot(ships, shot_coordinates, ship)
    hit = false
    ships.each do |coord|
      if coord.include?(shot_coordinates)
        hit = true
        ship = coord[0]
      end
    end
    return hit, ship
  end

  def strike(ships, shot_coordinates = "")
    hit, ship = shot(ships, shot_coordinates, ship)
    ships.delete_if { |x| x.include?(ship) } if hit
  end
end
