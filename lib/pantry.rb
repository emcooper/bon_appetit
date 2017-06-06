
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
    result = {:quantity => u_units, :units => "Universal Units"}
    to_centi_units(result) if u_units > 100
    to_milli_units(result) if u_units < 1  
    return result
  end 
  
  def to_centi_units(result)
    result[:quantity] /= 100 
    result[:units] = "Centi-Units"
  end 
  
  def to_milli_units(result)
    result[:quantity] *= 1000 
    result[:units] = "Milli-Units"
  end 
  
  def add_to_shopping_list(recipe)
    recipe.ingredients.each do |k, v|
      @shopping_list[k] = 0 if @shopping_list[k].nil?
      @shopping_list[k] += v
    end 
  end 
end
