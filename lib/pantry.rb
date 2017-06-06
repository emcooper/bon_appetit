class Pantry
  attr_reader :stock
  def initialize
    @stock = {} 
  end 
  
  def stock_check(item)
    return 0 if @stock[item].nil?
    return @stock[item]
  end 
  
  def restock(item, quantity)
    @stock[item] = 0 if @stock[item].nil?
    @stock[item] += quantity
  end 
end
