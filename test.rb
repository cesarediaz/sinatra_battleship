require File.expand_path '../test_helper.rb', __FILE__

class MyTest < MiniTest::Unit::TestCase

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_home
    get '/'
    assert last_response.ok?
    assert_match "BattleShip", last_response.body
  end

  def test_shot
    post '/'
  end

end
