class Player
  attr_accessor :name, :dominos, :turn
  def initialize(name, table, dominos = [])
    @name, @table, @dominos= name, table, dominos
  end  
  
  def move(match_domino)
    @index = nil
    loop do
      break if match_domino.empty?
      @domino = GUI.new.get_key 
      if @dominos.include?(match_domino[@domino-1]) then
        @index = @dominos.index(match_domino[@domino-1]) if not match_domino.empty?
        break 
      end
    end
    @index
  end
   
  def direction(direction)
    if direction == "l" then
      return Table::LEFT
    else return Table::RIGHT
    end
  end
  
  def push(element, direction)
      @table.push(@dominos[element],direction)
      @dominos.slice!(element)
  end
  
  def get_domino
    GUI.new.get_key       
  end
  
  def to_s
    text = ""
    @dominos.map { |domino| text += domino.to_s }
    text
  end

end
