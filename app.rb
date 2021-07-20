require 'bundler'
require 'pry'
require_relative 'lib/game'
require_relative 'lib/player'

player1=Player.new("José")
player2=Player.new("Josianne")

while player1.life_points > 0 && player2.life_points > 0
    puts "Voici l' état de chaque joueur :"
    puts player1.show_state
    puts player2.show_state
    puts ""
    puts "Passons à la phase d'attaque :"
    player1.attacks(player2)
    if player2.life_points > 0
      player2.attacks(player1)
    end
    if player1.life_points <= 0 || player2.life_points <= 0
      break
    end
end

# hp=HumanPlayer.new("Dark")
# hp.show_state
# hp.search_weapon
