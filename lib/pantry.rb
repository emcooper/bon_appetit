class Pantry
  attr_reader :stock, :shopping_list
  def initialize
    @stock = {} 
    @shopping_list = {}
  end 
  
  def stock_check(item)
    return 0 if @stock[item].nil?
    return @stock[item]
  end 
  
  def restock(item, quantity)
    @stock[item] = 0 if @stock[item].nil?
    @stock[item] += quantity
  end 
  
  def convert_units(recipe)
    converted_units = {}
    recipe.ingredients.each {|k, v| converted_units[k] = convert(v)}
    return converted_units
  end 
  
  def convert(u_units)
    result = [{:quantity => u_units, :units => "Universal Units"}]
    result = to_centi_units(result) if u_units > 100
    result = to_milli_units(result) if u_units % 1 != 0
    return result
  end 
  
  def to_centi_units(result)
    u_units = result[0][:quantity]
    result = [{:quantity => u_units/100, :units => "Centi-Units"}]
    result << {:quantity => u_units % 100, :units => "Universal Units"} if u_units % 100 != 0
    return result
  end 
  
  def to_milli_units(result)
    u_units = result[0][:quantity]
    result = [{:quantity => ((u_units % 1).round(10) * 1000).to_i, :units => "Milli-Units"}]
    result << {:quantity => u_units.to_i, :units => "Universal Units"} if u_units > 1
    return result
  end 
  
  def add_to_shopping_list(recipe)
    recipe.ingredients.each do |k, v|
      @shopping_list[k] = 0 if @shopping_list[k].nil?
      @shopping_list[k] += v
    end 
  end 
  
  def print_shopping_list
    output = ""
    @shopping_list.each {|k, v| output << "* #{k}: #{v}\n"}
    puts output
    return output
  end 
end
