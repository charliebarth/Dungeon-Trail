class Monster < Parent
    attr_accessor :name, :health, :size, :weapon, :status, :room, :attack_value
  
    @@all = []
    
    def initialize(name, size, room, weapon = nil)
      @room = room
      @health = nil
      @attack_value = nil
      @status = "Alive"
      @name = name
      @size = size
      @useable_weapon = weapon
      @@all << self
      self.monster_health
    end
  
    def self.all
      @@all
    end
  
    def monster_damage
      if @useable_weapon != nil
        @attack_value = @useable_weapon.damage
      else
        if @size == "Large"
          @attack_value = 10
          @health = 55
        elsif @size == "Medium"
          @attack_value = 7
          @health = 40
        else
          @attack_value = 5
          @health = 25
        end
      end
    end
  
    def monster_health
      if @size == "Large"
        @health = 55
      elsif @size == "Medium"
        @health = 40
      else
        @health = 25
      end
    end
  
  
    def attack(current_player)
      current_player.reduce_health(@attack_value)
      current_player.add_health
    end
  end