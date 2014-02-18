require 'minitest'
require 'minitest/autorun'
require 'delve'

class DelveTest < Minitest::Test

  def setup
    @name = 'Dungeon Crawler'
    @delve = Delve.new @name
  end

  def test_initialize_without_name_fails
    assert_raises RuntimeError do
      Delve.new nil
    end
  end

  def test_set_unknown_renderer_fails
    assert_raises RuntimeError do
      @delve.use_renderer :train
    end
  end

  def test_default_renderer_is_curses
    assert_equal :curses, @delve.renderer
  end

  def test_set_unknown_generator_fails
    assert_raises RuntimeError do
      @delve.use_generator :window
    end
  end

  def test_default_generator_is_rogue
    assert_equal :rogue, @delve.generator
  end

end
