require 'minitest'
require 'minitest/autorun'
require 'delve/generator/noise'

class NoiseTest < Minitest::Test

  def test_not_defining_grain_fails
    assert_raises RuntimeError do
      Noise.new 10, 10, nil
    end
  end

  def test_passing_unknown_grain_fails
    assert_raises RuntimeError do
      Noise.new 10, 10, :something
    end
  end

  def test_width_less_than_zero_fails
    assert_raises RuntimeError do
      Noise.new -1, 10, :fine
    end
  end

  def test_height_less_than_zero_fails
    assert_raises RuntimeError do
      Noise.new 10, -1, :fine
    end
  end

  def test_generate_fine_noise
    m = mock('object')
    m.expects(:handle).times(9)
    noise = Noise.new 3, 3, :fine
    noise.generate do |x, y, value|
      m.handle(x, y, value)
    end
  end

  def test_generate_coarse_noise
    m = mock('object')
    m.expects(:handle).times(4)
    noise = Noise.new 2, 2, :coarse
    noise.generate do |x, y, value|
      m.handle(x, y, value)
    end
  end

end
