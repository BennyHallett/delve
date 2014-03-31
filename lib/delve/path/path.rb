class Path
  
  def initialize(to_x, to_y, free_checker, options = Hash.new)
    raise 'Cannot initialize path if to_x is nil' if to_x.nil?
    raise 'Cannot initialize path if to_y is nil' if to_y.nil?
    raise 'Cannot initialize path if free checker is nil' if free_checker.nil?
  end

end
