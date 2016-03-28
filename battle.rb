# Battle class represent all actions in battleship game
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

  def strike(ships, shot_coordinates = '')
    hit, ship = shot(ships, shot_coordinates, ship)
    ships.delete_if { |x| x.include?(ship) } if hit
  end

  def result(settings, shot_coordinates)
    result = ''
    if settings.system_ships.empty?
      result = 'winner'
    elsif settings.ships.empty?
      result = 'loser'
    end
    { status: 'success', result: result, shot_coordinates: shot_coordinates }.to_json
  end
end
