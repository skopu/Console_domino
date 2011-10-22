class SebaAI < Player
  def move(match_domino)
    return (match_domino.empty?) ? nil : @dominos.index(match_domino[rand(match_domino.size)])
#    if match_domino.empty? then
#      @index = nil
#    else
#      @index = @dominos.index(match_domino[rand(match_domino.size)])
#    end
#    return @index
  end
    
  def direction
    return (rand(2)==1) ? Table::RIGHT : Table::LEFT
  end
  
  def get_domino
    true
  end
end
