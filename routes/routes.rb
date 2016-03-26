get '/' do
  settings.ships = Grid.new.ships_positions
  settings.system_ships = Grid.new.ships_positions
  settings.machine_grid = Grid.new.initial_grid
  haml :"index", locals: { ships: settings.ships, system_ships: settings.system_ships }
end

post '/shot' do
  content_type :json

  battle = Battle.new

  # Shot from human
  battle.strike(settings.system_ships, params[:id])
  puts "Machine ships: #{settings.system_ships.size}\n"

  # Shot from machine
  shot_coordinates = settings.machine_grid.sample
  settings.machine_grid.delete shot_coordinates
  battle.strike(settings.ships, shot_coordinates)
  puts "Human ships: #{settings.ships.size}\n"

  if settings.system_ships.empty?
    { :status => 'success', :result => 'winner' }.to_json
  elsif settings.ships.empty?
    { :status => 'success', :result => 'loser' }.to_json
  end
end
