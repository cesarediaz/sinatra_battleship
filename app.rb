require 'sinatra'
require 'yaml'
require 'json'

require './routes/routes'
require './lib/grid.rb'
require './lib/battle.rb'

set :title, 'BattleShip'
set :root, File.dirname(__FILE__)
set :views, settings.root + '/views'

set :ships, []
set :system_ships, []
set :machine_grid, []
