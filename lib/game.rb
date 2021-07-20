require 'bundler'
Bundler.require


class Game
    attr_accessor :enemies, :player, :human_player
    def initialize(name, nb_enemies)
        @human_player = HumanPlayer.new(name)
        @enemies = Array.new
        nb_enemies.times{ |el| @enemies << Player.new("bot_#{el+1}")}   
    end

    def welcome_msg
        puts "\033[35m+-----------------------------------------------+\033[0m"
        puts "\033[35m|Bienvenue sur 'ILS VEULENT TOUS MA POO III' !  |\033[0m"
        puts "\033[35m|Le but du jeu est TOUJOURS d'être le dernier ! |\033[0m"
        puts "\033[35m+-----------------------------------------------+\033[0m"
    end

    def kill_player(player)
        @enemies.select!{|enemies| enemies.name = player}
    end

    def is_still_ongoing?
        if @human_player.life_points >0 && @enemies.length > 0
            return true
        else
            return false
        end
    end

    def show_players
        puts "Voici votre état :"
        if @human_player.life_points > 25
        puts "\033[32m#{@human_player.name} a #{@human_player.life_points} PV et une arme de niveau #{@human_player.weapon_level}!\033[0m"
        else
            puts "\033[31m#{@human_player.name} a #{@human_player.life_points} PV et une arme de niveau #{@human_player.weapon_level}!\033[0m"
        end          
        puts "\033[31mIl reste #{@enemies.length} bots restant \033[0m"
        touch_for_continue

    end

    def sep
        puts "\033[35m+-----------------------------------------------+\033[0m"
    end

    def touch_for_continue
        sleep(0.5)
        puts "\033[32m--------------Pressez une touche pour continuer ➤\033[0m"
    end
    
    def end_game
        if @human_player.life_points <= 0 
            puts ""
            puts "(҂ X_X)  †††† Tu es moooort †††† "
            puts ""
           elsif @enemies.length <= 0
            puts "" 
            puts "\033[32m   ʘ‿ʘ  Tu as gagné, bravo\033[0m"
            puts ""
           else
             puts 'OUPS'
           end
    end


    def menu
        choice=""
        puts "Quelle action veux-tu effectuer ?"
        puts "a - chercher une meilleure arme"
        puts "s - chercher à se soigner "
        puts ""
        puts "attaquer un joueur en vue :"
        i=0
        @enemies.each_with_object([]) do |item|
          puts "#{i} - #{item.name} a #{item.life_points} PV"if item.life_points >0
          i+=1
        end
        print ">"
        choice=gets.chomp.to_s
        if choice == "a"
            @human_player.search_weapon
            elsif choice == "s"
              @human_player.search_health_pack
            elsif choice != "" && choice.to_i <= ((@enemies.size) - 1) 
              e=choice.to_i
              target = @enemies.each_with_object({}).with_index do |(item, accessor), index|
                accessor[index] = item
              end
                  if target[e].life_points > 0
                     @human_player.attacks(target[e])
                     puts target[e].show_state
                     else 
                     puts "#{target[e].name} est mort "
                 end
             elsif choice.to_i >= ((@enemies.size) - 1)
              return menu
             else
            puts 'Essayer d\'eteindre et rallumer votre routeur'
            end
           end    
end
