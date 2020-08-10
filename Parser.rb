require 'net/http'
require 'open-uri'
require 'json'
require "./Equipment"
 
class Parser
 
  URL = "https://www.dnd5eapi.co/api/equipment"

  @@names = []

 
  def get_equipment
    uri = URI.parse(URL)
    response = Net::HTTP.get_response(uri)
    response.body
  end
  
  def parse_equipment
    programs = JSON.parse(self.get_equipment)
    programs["results"].each do |hash|
        @@names << hash["index"]
    end
    @@names
  end

  def filter_array
    @array = []
    @@names.each do |text|
      #text = @@names[1]
      if ["rope-hempen-50-feet", "scale-mail", "acid-vial", "chain-mail", "leather", "shield", "club", "dagger", "greataxe", "warhammer", "longsword", "torch" ].include? "#{text}"
        @array << text
      end
    end
  end


  def get_item
    @@names.each do |text|
    #text = @array[1]
    #text = @@names[1]
      if ["rope-hempen-50-feet", "scale-mail", "acid-vial", "chain-mail", "leather", "shield", "club", "dagger", "greataxe", "warhammer", "longsword", "torch" ].include? text
      #if text == "rope-hempen-50-feet" || text == "scale-mail" || text == "acid-vial" || text == "chain-mail" || text == "leather" || text == "shield" || text == "scale-mail" || text == "club" || text == "dagger" || text == "greataxe" || text == "warhammer" || text == "longsword" || text == "torch" || text == "acid-vial"
        new_url = "https://www.dnd5eapi.co/api/equipment/#{text}"
        uri = URI.parse(new_url)
        response = Net::HTTP.get_response(uri)
        hash = JSON.parse(response.body)
            item_name = hash["name"]
            cost_hash = hash["cost"]
            cost_quantity = cost_hash["quantity"]
            armor_base = nil
            if hash.include? "armor_class"
              ac_hash = hash["armor_class"]
              armor_base = ac_hash["base"]
            end
            if armor_base == nil
              if item_name == "Club"
                Equipment.new(item_name, cost_quantity, nil, 4)
              elsif item_name == "Longsword"
                Equipment.new(item_name, cost_quantity, nil, 8)
              elsif item_name == "Greataxe"
                Equipment.new(item_name, cost_quantity, nil, 12)
              elsif item_name == "Warhammer"
                Equipment.new(item_name, cost_quantity, nil, 10)
              elsif item_name == "Dagger"
                Equipment.new(item_name, cost_quantity, nil, 4)
              else
                Equipment.new(item_name, cost_quantity)
              end
            end
            if armor_base != nil
              Equipment.new(item_name, cost_quantity, armor_base)
            end
      end
    end
  end

  #  def parse_item
  #   array_one = []
  #   programs = JSON.parse(self.get_item)
  #   programs.each do |hash|
  #     array_one << hash
  #   end
  #   array_one
  #  end

#   def create_equipment
#     @@names.each do |string|
#       if string.include? "("
#         !string["("] = ""
#       end
#       if string.include? ")"
#         !string[")"] = ""
#       end
#       new_s = string.split
#       if new_s.size > 1
#         @@new_array << new_s.join("-").downcase
#       else
#         @@new_array << new_s
#       end
#     end
#   end
  
 
end

#programs = GetPrograms.new.get_programs
#puts programs

# programs = Parser.new
# #programs.get_equipment
# programs.parse_equipment
# #programs.create_equipment
# programs.filter_array
# programs.get_item
# #puts programs.parse_item