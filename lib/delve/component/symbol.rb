class SymbolComponent
  def initialize(parent, symbol, color=:white)
    raise 'Cannot create symbol component when parent is nil' unless parent
    raise 'Cannot create symbol component when symbol is nil' unless symbol

    @parent = parent
    @symbol = symbol
    @color = color
  end

  def id
    :symbol
  end

  def symbol
    { :char => @symbol, :color => @color }
  end
end
