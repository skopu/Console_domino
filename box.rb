class Box
  attr_reader :box
  def initialize
    @box = []
    (0..6).each do |left|
      (0..left).each do |right|
        @box << Domino.new(left, right)
      end
    end
   end

  # losuje domino w pudełku  
  def random
    length = @box.size
    length.times do |item|
      position = rand(length)
      push(get(1, position))
    end
    self
  end

  # wyciąga określoną liczbę elementów z pudełka  
  def get(count = 1, offset = 0)
    return nil if @box.empty?
    result = @box[offset...offset+count]
    rest = @box[0...offset] + @box[offset+count...@box.size]
    @box = rest
    result
  end
  
  # wklada domino do pudełka
  def push(dominos = [])
    @box += dominos
    self
  end
end
