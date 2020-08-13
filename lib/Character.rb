class Character < Parent
    attr_accessor :name, :health, :status, :wealth, :weapon, :light, :armor
    @@all = []
  
    def initialize(name)
      @weapon = nil
      @armor = nil
      @light = "Dark"
      @status = "Alive"
      @wealth = 75
      @health = 35
      @name = name
      @inventory = []
      @@all << self
    end
  
    def self.all
      @@all
    end
  
    def buy_item(equipment_object)
      Equipment.all.each do |x|
        if x.name == equipment_object
          if @wealth >= x.cost
            value = x.cost
            @wealth += -(value)
            puts "You bought this item. Your current gold total is: #{@wealth} gp"
            self.add_to_inventory(x)
          else
            puts "You cannot afford this item. Your current gold total is: #{@wealth} gp."
          end
        end
      end
    end
  
    def add_to_inventory(item)
      @inventory << item
    end
  
    def display_inventory
      if @inventory.size == 0
        puts "Your inventory is currently empty."
      else
        @inventory.each do |item|
          puts item.name
        end
        puts self.wealth
      end
    end
    
    def use(item, thing)
        if item == "Torch"
            @light = "Illuminated"
            puts "The torch illuminates the area around you allowing you to better search the area."
            puts "If you would like the search the room type 'Search'."
        elsif item == "Acid (vial)"
            puts "The #{thing} slowly begins to melt before you until it is eventually just a puddle of liquid on the floor."
        elsif item == "Rope, hempen (50 feet)"
            Monster.all.each do |monster|
                if monster.name == thing
                    monster.restrain
                end
            end
            puts "Using your rope you quickly tie up and restrain the #{thing}."
        else
            puts "The item doesn't seem to have any affect."
        end
    end 
    
    def current_weapon(item)
      @inventory.each do |x|
        if x.name == item
          if x.damage != nil
            @weapon = x
          else
            return false
          end
        end
      end
    end

    def current_armor(armor)
      Equipment.all.each do |x|
        if x.name == armor
          if x.armor_class != nil
            @armor = x
          else
            return false
          end
        end
      end
    end

    def display_armor
        puts @armor
        puts @armor.armor_class
    end


    def add_health
      if @armor != nil
        @health += (@armor.armor_class / 2)
      end
    end

    def add_wealth(value)
      @wealth += value
    end

  
    def attack(monster)
      monster.reduce_health(@weapon.damage)
    end

    def search
      if @light == "Illuminated"
        #room.contents
        true
      else
        puts "It's too dark to find anything."
      end
    end

    def dv
      @weapon.damage
    end
  
  
  end
  
# john = Character.new("John")
# item = Equipment.new("Leather", 10, 10)
# #john.current_armor(item)
# #john.display_armor
# john.add_health
# puts john.health
# john.death

  
  