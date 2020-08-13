class Room
    attr_accessor :name
    @@all = []
  
    def initialize(name)
      @name = name
      @contents = []
      @@all << self
    end
  
    def add(item)
      @contents << item
    end

    def self.all
      @@all
    end
  
    def self.display_room(room)
      if room == "One"
        puts "Before you lies a large dimly lit stone room. There is a sputtering torch at the far end of the room casting dancing shadows across the floor and walls. At the far end of the room you can make out a wooden door set into the wall and a diminutive figure next to the door. It's hunched over and slowly rocking back and forth while muttering something to itself. The rest of the room is old, cracked, and mossy covered stone. There are bits of wood and bone scattered across the stones."
      elsif room == "Two"
        puts "Entering the new room you immediately notice that the carved stone panels from the first room have given way to a dirt and stone cavern. Shuffling towards the back wall of the cave is a large grey troll. All that seems to be left in the cave is remains of what the troll ate and a pile of straw, nestled in a natural corner formed by the cave walls, providing a resting place."
      else
        puts "You hit a dead end. Pick a different path."
      end
    end
  
    # def contents
    #   @contents.each do |item|
    #     puts item.name
    #   end
    # end
  end
  
  # puts Room.new("Any").contents
  # x = Room.new("One")
  # y = Room.new("Two")
  # x.display_room
  # y.display_room
  