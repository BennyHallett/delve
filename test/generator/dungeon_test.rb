require 'minitest'
require 'minitest/autorun'
require 'delve/generator/dungeon'

class DungeonTest < Minitest::Test

  def setup
    @dungeon = Dungeon.new
  end

  def test_no_rooms_exist
    assert !@dungeon.rooms.nil?
    assert_equal 0, @dungeon.rooms.length
  end

  def test_no_corridors_exist
    assert !@dungeon.corridors.nil?
    assert_equal 0, @dungeon.corridors.length
  end

end
