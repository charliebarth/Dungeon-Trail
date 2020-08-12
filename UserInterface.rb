require "./Equipment.rb"
require "./Room.rb"
require "./Monster.rb"
require "./Character.rb"
require "./Parser.rb"
class UserInterface

    attr_accessor :character, :current_player, :current_room, :current_location, :room_one, :room_two, :goblin, :troll
  
   
    
    def initialize
      programs = Parser.new
      programs.parse_equipment
      programs.get_item
      @goblin = Monster.new("Goblin", "Small", "One")
      @troll = Monster.new("Troll", "Medium", "Two")
      @goblin.monster_damage
      @troll.monster_damage
      @room_one = Room.new("One")
      @room_two = Room.new("Two")
      @current_location = @room_one
      @current_player = nil
      @current_room = nil
    end
  
    def start

      puts "Welcome to Dungeon Trail!"
      puts "Please start by naming your character."
      name = gets.chomp
      @current_player = Character.new(name)

      puts "If you every need to see a list of all available commands/actions type 'List'."

      @current_player.display_inventory
  
      puts "You should buy items to fill your inventory and equip your character."
      puts "To buy an item type 'Buy'. Then you will be promted to select an item."
      puts "You have #{@current_player.wealth} gold pieces."
      Equipment.store
      self.call
    end

    def call

      input = gets.chomp
      
      case input
      
      when "List"
        puts "Here is a list of possible commands: Buy, Move, Search, Attack, Inventory, Use, End, Health"
        self.call
      
      when "Buy"
        puts "Please type in the complete name of the item you would like the buy or type 'Begin Quest' to being the adventure."
        @current_player.buy_item(gets.chomp)
        if self.game_over? == "Won"
          puts "You beat the game. To exit type 'End'."
        end
        self.call
      
      when "Move"
        if @current_location.name == "One"
          @current_location = @room_two
          Room.display_room(@current_location.name)
        elsif @current_location == "Two"
          @current_location = @room_one
          Room.display_room(@current_location.name)
          Equipment.all.each do |x|
            if x.name == "Dagger"
              @current_location.add(x)
            end
          end
        end
        if self.game_over? == "Won"
          puts "You beat the game. To exit type 'End'."
        end
        self.call
      
      when "Search"
        if @current_location.name == "One"
          puts "Inspecting the room closer you find pieces of a wooden chair, a small doll made of straw and several burned books."
        elsif @current_location.name == "Two"
          if @current_player.search
            puts "You find a small iron dagger and a small pouch of gold."
            Equipment.all.each do |x|
              if x.name == "Dagger"
                @current_player.add_to_inventory(x)
              end
            end
          end
          @current_player.add_wealth(15)
        end
        if self.game_over? == "Won"
          puts "You beat the game. To exit type 'End'."
        end
        self.call

      when "Health"
        puts @current_player.health
        self.call
          
      
      when "Attack"
        Monster.all.each do |x|
          if x.room == @current_location.name
          self.combat(x)
          end
        end
        if self.game_over? == "Won"
          puts "You beat the game. To exit type 'End'."
        end
        
      
      when "Inventory"
        @current_player.display_inventory
        if self.game_over? == "Won"
          puts "You beat the game. To exit type 'End'."
        end
        self.call
      
      when "Use"
        puts "Type in the full name of the item you would like to use"
        item = gets.chomp
        puts "If you would like the use the object on a specific item please type in the name of that object."
        object = gets.chomp
        @current_player.use(item, object)
        if self.game_over? == "Won"
          puts "You beat the game. To exit type 'End'."
        end
        self.call
      
      when "Begin Quest"
        puts "First you need to equip a weapon."
        if @current_player.current_weapon(gets.chomp)
          puts "Second you need to equip an armor set"
        else
          puts "You put in an invalid item. Try Again."
          @current_player.current_weapon(gets.chomp)
          puts "Second you need to equip an armor set"
        end
        if @current_player.current_armor(gets.chomp)
        else
          puts "You put in an invalid item. Try Again."
          @current_player.current_current_armor(gets.chomp)
        end
        if @current_player.weapon != nil && @current_player.armor != nil
          puts "Excellent, let's begin!"
          sleep 2
          puts "You found the entrance a lost dungeon and decided to explore to see what you could find."
          Room.display_room(@current_location.name)
          puts "What would you like to do?"
        end
        self.call

      when "End"
        if self.game_over? == "Lost"
          begin
            exit
          rescue SystemExit
          end
        elsif self.game_over? == "Won"
          puts "Congratulations! You beat the game!"
          begin
            exit
          rescue SystemExit
          end
        end

      else
        if self.game_over?
          puts "The game isn't over yet."
        end
        self.call
      end
    end
    
    def combat(monster)
      self.attack(@current_player.dv, monster)
      until @current_player.status == "Dead" || monster.status == "Dead"
        self.attack(monster.attack_value, @current_player)
        self.attack(@current_player.dv, monster)
        # puts "Damage taken: #{monster.damage}, Health left: #{@current_player.health}"
        # @current_player.attack(monster)
        # if @current_player.current_weapon == "Longsword"
        #   puts "Damage dealt: 8, Monster health left: #{@monster.health}"
        # elsif @current_player.current_weapon == "Greataxe"
        #   puts "Damage dealt: 12, Monster health left: #{@monster.health}"
        # elsif @current_player.current_weapon == "Warhammer"
        #   puts "Damage dealt: 10, Monster health left: #{@monster.health}"
        # else
        #   puts "Damage dealt: 4, Monster health left: #{@monster.health}"
        #end
      end
      if self.game_over?
        puts "You killed the #{monster.name} and won the game. You can continue to play or end the game by typing 'End'."
      else
        puts "You killed the monster."
      end
      self.call
    end

    def attack(damage_value, target)
      if target == @current_player
        x = damage_value / 2
        target.health += -(x)
      else 
        target.health += -(damage_value)
      end
      target.death
    end

  
    def game_over?
      if @current_player.status == "Dead"
        puts "You died. Game Over"
        return "Lost"
      elsif @goblin.status == "Dead" && @troll.status == "Dead"
        return "Won"
      else
        return true
      end
    end
  
  end
  #UserInterface.new.start
  
  