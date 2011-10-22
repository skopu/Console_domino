#!/usr/bin/env ruby
# coding: utf-8

#Task 9.
#Gra w domino w wersji konsolowej. Wszystko zrobione na klasach i obiektowo. Rozdzielone GUI od logiki.

require File.dirname(__FILE__)+'/domino.rb'
require File.dirname(__FILE__)+'/table.rb'
require File.dirname(__FILE__)+'/box.rb'
require File.dirname(__FILE__)+'/player.rb'
require File.dirname(__FILE__)+'/rules.rb'
require File.dirname(__FILE__)+'/gui.rb'
require File.dirname(__FILE__)+'/seba_ai.rb'
################################################################################
class DominoGame
attr_reader :players, :table, :box
  def initialize(box, table, players= [])
    @box, @table = box, table
    @players = []
    players.each do |name|
      @players << Player.new(name, @table)
    end
    @players << SebaAI.new("komp", @table)
  end
  
  def add_domino(index, number,offset=0)
    @players[index].dominos += @box.random.get(number,offset)    
  end
  
  def push_domino(index, element, direction)
    @players[index].push(element,direction)    
  end
  
  def rotate_domino(index, domino)
    @players[index].dominos[domino].rotate
  end
  def domino_to_box(domino, player)
    @box.box.push(@players[player].dominos[domino])
  end
  def win(id)
    print "#########################\nWygraywa gracz: #{@players[id].name}!!!\n##############################\n"
    @players.each do |player| 
      @box.push(player.dominos)
      player.dominos.clear
    end
    @box.push(@table.table)
    @table.table.clear
    return 0
  end
  
end

number = 0
loop do
  p "wybierz ilość graczy"
  number = gets.chomp.to_i
  break if number > 0
end
players = []
p "podaj nazwy graczy:"
number.times do
  players << gets.chomp
end

game = DominoGame.new(Box.new, Table.new, players)
gui = GUI.new
DominoRules.new(game.table).first_random(game)
print "Wylosowana kolejnosc graczy: "
game.players.each do |player|
print " #{player.name}"
end
choice = 1
loop do
  choice = gui.play(game,choice)
  break if choice ==0
end

