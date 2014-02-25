class SymbolComponent
  def initialize(parent, symbol)
    raise 'Cannot create symbol component when parent is nil' unless parent
    raise 'Cannot create symbol component when symbol is nil' unless symbol

    @parent = parent
    @symbol = symbol
  end

  def id
    :symbol
  end

  def symbol
    @symbol
  end
end
