class TextWidget
  def initialize(x, y, text)
    raise 'Cannot initialize text widget when x is nil' unless x
    raise 'Cannot initialize text widget when y is nil' unless y
    raise 'Cannot initialize text widget when text is nil' unless text
  end
end
