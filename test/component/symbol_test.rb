require 'minitest'
require 'minitest/autorun'
require 'delve/component/symbol'
require 'mocha/setup'

class SymbolComponentTest < Minitest::Test

  def setup
    @parent = mock('object')
    @symbol = 'x'
    @component = SymbolComponent.new @parent, @symbol
  end

  def test_initialize_component_with_nil_parent_fails
    assert_raises RuntimeError do
      SymbolComponent.new nil, @symbol
    end
  end

  def test_initialize_component_with_nil_symbol_fails
    assert_raises RuntimeError do
      SymbolComponent.new @parent, nil
    end
  end

  def test_get_symbol
    assert_equal @symbol, @component.symbol
  end

end
