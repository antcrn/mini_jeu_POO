require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


def perform
    game=Game.new("ZinZin", 4)
    game.welcome_msg
    while game.is_still_ongoing?
        game.show_players
        game.sep
        game.menu
        game.sep
        puts "Les autres joueurs t'attaquent !"if game.enemies.length > 0 
        game.enemies.each_with_object([]) do |item|
          if item.life_points > 0
            item.attacks(game.human_player)
          else 
              puts "#{item.name} est mort "
              game.enemies.delete(item)
          end
        end
        game.sep
        game.touch_for_continue
        puts "\033[30m#{gets.chomp}\033[0m"
    end
    game.end_game
    
    end

perform
