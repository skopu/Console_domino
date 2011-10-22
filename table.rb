class Table 
  attr_accessor :table 
  LEFT = -1
  RIGHT = 1
  ROTATE = :rotate
  DIRECTION = :direction  
  def initialize
    @table = []

  end
  #dodaje domino na stół
  def push(element = [], direction = 0)
    @table << element if direction==RIGHT
    @table = [element] + @table if direction==LEFT
  end
  
  def to_s
    text = ""
    @table.map { |domino| text += domino.to_s }
    text
  end
end
