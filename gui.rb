class GUI
  def play(game, choice)
      id=0
      @choice = choice
      unless @choice == 2 then
        print "\n[0]-koniec, [1]-wybierz liczbe elementow i zacznij gre: " 
        @choice = gets.chomp.to_i  
      end
      case @choice
        when 0 then return @choice
        when 1    
          loop do
            p "wybierz po ile elementow losuje gracz(2-7)"
            @elements = gets.chomp.to_i
            break if @elements <8 and @elements>1
          end
          game.players.each do |player|    
            game.add_domino(id,@elements)
            #p game.players[id]  
            id+=1  
          end
          return @choice = 2 
        when 2   
          rules = DominoRules.new(game.table)
          player = game.players[id]
          table = game.table.table
        
            game.players.each do |player|   
              match_domino = rules.match_dominos(game,id)
              print "\n#{player.name}\ntable->  #{game.table}\ndomina gracza-> #{game.players[id]}\nwybierz domino(1,2...n)\n"
              match_domino.each_index do |number|
                print "#{number+1}:#{match_domino[number]} "
              end
              index = player.move(match_domino)
              
           #   rules.empty_table?(table,domino,player)
                if index == nil then
                  p "Niestety nie masz pasujacych klockow ,zostanie pobrane dodatkowe domino, nacisnij klawisz Enter..."
                  player.get_domino
                  game.add_domino(id,1,0)
                  p "Wylosowales ->  #{game.players[id].dominos.last}" 
                else
                  domino = game.players[id].dominos[index]
                  case rules.check_add(domino)
                    when Table::RIGHT
                      player.push(index,Table::RIGHT)
                    when Table::LEFT
                      player.push(index,Table::LEFT)
                    when [Table::ROTATE, Table::RIGHT]
                      game.rotate_domino(id,index)
                      player.push(index,Table::RIGHT)
                    when [Table::ROTATE, Table::LEFT]
                      game.rotate_domino(id,index)
                      player.push(index,Table::LEFT)
                    when [Table::ROTATE, Table::DIRECTION]
                      game.rotate_domino(id,index)
                      p "wybierz strone p lub l"
                      player.push(index, player.direction(gets.chomp))
                    when Table::DIRECTION
                      p "wybierz strone p lub l"
                      player.push(index, player.direction(gets.chomp))      
                  end
                  p "table po ruchu-> #{game.table}"  
                end
                if rules.win(game, id) == true then
                  @choice =1
                  break
                end
              
              id+=1
            end
        end 
    return @choice
  end
  
  def get_key
    gets.chomp.to_i     
  end
  
end
