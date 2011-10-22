class Domino
  def initialize(value1, value2)
    @square = [value1, value2]
  end
  
  def rotate
    @square[1], @square[0] = @square[0], @square[1]
  end
  def left
    @square[0]
  end
  def right
    @square[1]
  end
  def to_s
    "[#{@square[0]}|#{@square[1]}]"
  end
end
