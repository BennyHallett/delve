require 'minitest'
require 'minitest/autorun'
require 'delve/generator/noise'

class NoiseTest < Minitest::Test

  def test_width_less_than_zero_fails
    assert_raises RuntimeError do
      Noise.new -1, 10
    end
  end

  def test_height_less_than_zero_fails
    assert_raises RuntimeError do
      Noise.new 10, -1
    end
  end

end
