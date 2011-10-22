class DominoRules
  def initialize(table)
    @table = table
  end
  def correct?(table,element_add,direction)
    return true if table.empty? 
    if direction==1 then
      return true if table.last.right == element_add.left
      elsif direction==-1 then
      return true if table.first.left == element_add.right
    end
    false    
  end
  #losowanie kolejności graczy
  def first_random(game)
    id=0
    @domino = []
    game.players.each do |player|
      game.players[id].dominos << game.add_domino(id,1,rand(game.box.box.size))
      @domino << game.players[id].dominos[0].left + game.players[id].dominos[0].right
      id+=1
    end
    game.players.sort!{|a,b| a.dominos[0].left + a.dominos[0].right <=>b.dominos[0].left + b.dominos[0].right }
    game.players.reverse!
    id=0
    game.players.each do |player|
      game.domino_to_box(0,id)
      game.players[id].dominos.slice!(0)
      id+=1
    end
  end
  #zwraca które domina moża wyłożyć na stół
  def match_dominos(game,id)
    match_domino_index= []
    match_domino = []
    if game.table.table.empty? then
      (0...game.players[id].dominos.size).each do |number|
        match_domino_index << number
      end
      else
      t_right = game.table.table.last.right
      t_left = game.table.table.first.left
      game.players[id].dominos.each_index do |index|
        if t_right == game.players[id].dominos[index].left or t_left == game.players[id].dominos[index].right then
          match_domino_index << index if !match_domino_index.include?(index)
        end
        game.rotate_domino(id,index) 
        if t_right == game.players[id].dominos[index].left or t_left == game.players[id].dominos[index].right then
          match_domino_index << index if !match_domino_index.include?(index)
        end
      end
    end
    match_domino_index.each do |number|
      match_domino << game.players[id].dominos[number]
    end
    match_domino
  end

  def win(game, id)
    if game.players[id].dominos.empty? then
      game.win(id)
      return true
    end
  end
  
 
  
  #sprawdza i dodaje poprawnie domina na stół
  def check_add(domino)
    if @table.table.empty? then
      return Table::RIGHT
    else
      table_r = @table.table.last.right
      table_l = @table.table.first.left
      right = true if domino.left == table_r
      left = true if domino.right == table_l
      rotate_right = true if domino.right == table_r
      rotate_left = true if domino.left == table_l
      #konce domina takie same    
      if domino.left == domino.right then
        if table_r == table_l then
         return Table::DIRECTION
        elsif right
          return Table::RIGHT
        elsif left
         return Table::LEFT
        end
      else
        #domina pasuja do lewej i prawej strony stołu
        if right and left then
          return Table::DIRECTION
        elsif rotate_right and rotate_left then
          return [Table::ROTATE, Table::DIRECTION]  
        #domina pasują tylko do jedenej ze stron
        elsif right
          return Table::RIGHT
        elsif left
          return Table::LEFT
        elsif rotate_right
          return [Table::ROTATE, Table::RIGHT]
        elsif rotate_left
          return [Table::ROTATE, Table::LEFT]
        end
      end
    end
  end
 
end
