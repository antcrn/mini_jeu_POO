require 'pry'



###################################
# CLASS PLAYER                   ##
###################################

class Player
    attr_accessor :name, :life_points
    @@players_all = []

    def initialize(name)
        @name = name
        @life_points = 10
        @@players_all << self
    end
    
    def self.all_players
        @@players_all.each do |player|
        return player
        end
    end
    
    def show_state
        puts "\033[33m#{self.name} à #{self.life_points} points de vie\033[0m"
        if self.life_points <=0
           self.life_points=0
        puts "Le joueur #{self.name} a été tué !"
        end   
    end

    def gets_damage(int)
        self.life_points -= int
    end

    def attacks(player)
        if player.life_points > 0
        atk = compute_damage
        player.gets_damage(atk)
        puts "#{self.name} attaque #{player.name}"
        puts "il lui inflige #{atk} points de dommages"
        puts ""
        end
    end

    def compute_damage
        return rand(1..6)
    end

end

###################################
# CLASS HUMANPLAYER              ##
###################################
class HumanPlayer < Player
    attr_accessor :weapon_level
  
    def initialize(name_of_player)
      @name = name_of_player
      @life_points = 100
      @weapon_level = 1
    end
  
    def show_state
        puts "\033[32m#{self.name} a #{self.life_points} points de vie et une arme de niveau #{self.weapon_level}!\033[0m"
    end
  
    def compute_damage
      rand(1..6) * @weapon_level
    end
  
    def search_weapon
        weapon_level_new = rand(1..6)
      puts "Tu as trouvé une arme de niveau #{weapon_level_new}"
      if @weapon_level < weapon_level_new
        @weapon_level=weapon_level_new         
        puts "TOP ! elle a l'air bien plus puissante que celle que tu possédes : tu la gardes."
      else 
        puts "M@*#$... elle n'est pas mieux que ton arme actuelle...... cette arme te filerais le tétanos..."
      end
    end
  
    def search_health_pack
      health_pack = rand(1..6)
      if health_pack == 1
        puts "Tu n'as rien trouvé..." 
      elsif health_pack <= 2 && health_pack <= 5
        puts "Bravo, tu as trouvé un pack de +50 points de vie !"
        @life_points += 50
      else
        puts "Waow, tu as trouvé un pack de +80 points de vie !"
        @life_points += 80
      end
      @life_points > 100 ? @life_points = 100 : @life_points
      puts @life_points
    end
  
  end
  