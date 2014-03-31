require 'minitest'
require 'minitest/autorun'
require 'delve/path/astar'

class AStarTest < Minitest::Test

  def setup
    @tox = 0
    @toy = 0
    @options = Hash.new
    @free_checker = mock('object')
    @free_checker.stubs(:respond_to?).with(:free?).returns(true)
    @astar = AStar.new @tox, @toy, @free_checker, @options
  end

  def test_compute_fails_if_no_block_is_passed
    assert_raises RuntimeError do
      @astar.compute 0, 0
    end
  end

end
