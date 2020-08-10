require "./Room.rb"
class Equipment
    attr_accessor :name, :description, :room, :cost, :armor_class, :damage
  
    @@all = []
    @@store = {}
  
    def initialize(name, cost, armor_class = nil, damage = nil)
      @damage = damage
      @room = room
      @name = name
      @cost = cost
      @armor_class = armor_class
      @@all << self
      Room.all.each do |x|
        if x.name == self.room
          x.add(self)
        end
      end
    @@store[:"#{self.name}"] = self.cost
    end
  
    def self.store
      puts "Item, Cost"
      @@store.each do|key, value|
        puts "#{key}, #{value}"
      end
    end

    def self.all
      @@all
    end
    
  end
# know = Room.new("One")
# armor = Equipment.new("Leather", 10, 10, "One")
# # armor.store
# know.contents