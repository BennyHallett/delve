require 'minitest'
require 'minitest/autorun'
require 'delve/path/path'

class PathTest < Minitest::Test

  def setup
    @tox = 0
    @toy = 0
    @options = Hash.new
    @free_checker = mock('object')
  end

  def test_initialize_fails_if_tox_is_nil
    assert_raises RuntimeError do
      Path.new nil, @toy, @free_checker
    end
  end

  def test_initialize_fails_if_toy_is_nil
    assert_raises RuntimeError do
      Path.new @tox, nil, @free_checker
    end
  end

  def test_initialize_fails_if_free_checker_is_nil
    assert_raises RuntimeError do
      Path.new @toy, @toy, nil
    end
  end

end
