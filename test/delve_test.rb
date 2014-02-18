require 'minitest'
require 'minitest/autorun'
require 'delve'

class DelveTest < Minitest::Test

  def setup
    @name = 'Dungeon Crawler'
  end

  def test_initialize_without_name_fails
    assert_raises RuntimeError do
      Delve.new nil
    end
  end

end
