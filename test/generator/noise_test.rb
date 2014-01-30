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

  def test_generate_noise
    m = mock('object')
    m.expects(:handle).times(9)
    noise = Noise.new 3, 3
    noise.generate do |x, y, value|
      m.handle(x, y, value)
    end
  end

end
