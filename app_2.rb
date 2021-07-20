require 'bundler'
require 'pry'
require_relative 'lib/game'
require_relative 'lib/player'

@all_players=[]
 @all_players << Player.new("José")  << Player.new("Josianne") << Player.new("Bull") << Player.new("Elton")

def menu
  choice=""
  puts "Quelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner "
  puts ""
  puts "attaquer un joueur en vue :"
  i=0
  @all_players.each_with_object([]) do |item|
    puts "#{i} - #{item.name} a #{item.life_points} PV"if item.life_points >0
    i+=1
  end
  print ">"
  choice=gets.chomp.to_s
  if choice == "a"
    @human_player.search_weapon
  elsif choice == "s"
    @human_player.search_health_pack
  elsif choice != ""   
    e=choice.to_i
    target = @all_players.each_with_object({}).with_index do |(item, accessor), index|
      accessor[index] = item
    end
        if target[e].life_points >0
           @human_player.attacks(target[e])
           puts target[e].show_state
           else 
           puts "#{target[e].name} est mort "
       end
   elsif choice.to_i >= (@all_players.size)
    p "OUPS"
     
  # when "1"
  #   if @player2.life_points >0
  #     @human_player.attacks(@player2)
  #     else 
  #         puts "#{@player2.name} est mort "
  #     end    
  else
  puts ''
  end
  


end



def perform
puts "\033[35m+-----------------------------------------------+\033[0m"
puts "\033[35m|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |\033[0m"
puts "\033[35m|Le but du jeu est d'être le dernier survivant !|\033[0m"
puts "\033[35m+-----------------------------------------------+\033[0m"


puts "Quel est ton nom, jeune héro ?"
print">"
@human_player = HumanPlayer.new(gets.chomp)
puts "Bonjour #{@human_player.name}"


while @human_player.life_points >0 && @all_players.length > 0
    puts "Voici votre état :"
    @human_player.show_state
    puts "\033[35m+-----------------------------------------------+\033[0m"
    menu
    puts "\033[35m+-----------------------------------------------+\033[0m"
    puts "Les autres joueurs t'attaquent !"if @all_players.length > 0 
    @all_players.each_with_object([]) do |item|
      if item.life_points >0
        item.attacks(@human_player)
      else 
          puts "#{item.name} est mort "
          @all_players.delete(item)
      end
    end
    puts "\033[35m+-----------------------------------------------+\033[0m"
    sleep(0.5)
    print"\033[32m--------------Pressez une touche pour continuer ➤\033[0m"
    puts "\033[30m#{gets.chomp}\033[0m"
end
if @human_player.life_points <= 0 
  puts ""
  puts "(҂ X_X)  †††† Tu es moooort †††† "
  puts ""
 elsif @all_players.length <= 0
  puts "" 
  puts "\033[32mʘ‿ʘ  Tu as gagné, bravo\033[0m"
  puts ""
 else
   puts 'OUPS'
 end
end
# binding.pry
perform