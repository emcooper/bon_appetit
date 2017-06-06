require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  def test_it_exists_and_initializes_with_empty_stock_and_shoppping_list
    pantry = Pantry.new
    
    assert_instance_of Pantry, pantry
    assert_equal ({}), pantry.stock
    assert_equal ({}), pantry.shopping_list
  end 
  
  def test_stock_check_returns_0_if_item_is_not_in_stock
    pantry = Pantry.new
    pantry.stock_check("cheese")
    
    assert_equal 0, pantry.stock_check("cheese")
  end 
  
  def test_stock_check_returns_quantity_if_item_is_in_stock
    pantry = Pantry.new
    pantry.stock["cheese"] = 10
    
    assert_equal 10, pantry.stock_check("cheese")
  end 
  
  def test_restock_adds_item_and_quantity_to_stock
    pantry = Pantry.new
    pantry.restock("cheese", 10)
    
    assert_equal 10, pantry.stock_check("cheese")
  end 
  
  def test_restock_adds_to_existing_item_quantity
    pantry = Pantry.new
    pantry.restock("cheese", 10)
    
    assert_equal 10, pantry.stock_check("cheese")
    
    pantry.restock("cheese", 40)
    
    assert_equal 50, pantry.stock_check("cheese")
  end 
  
  def test_stock_can_store_multiple_items
    pantry = Pantry.new
    pantry.restock("cheese", 10)
    pantry.restock("cereal", 30)
    
    assert_equal 10, pantry.stock_check("cheese")
    assert_equal 30, pantry.stock_check("cereal")
  end 
  
  def test_convert_units_converts_to_appropriate_units
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)
    pantry = Pantry.new
    
    expected = {"Cayenne Pepper" => {quantity: 25, units: "Milli-Units"},
                "Cheese"         => {quantity: 75, units: "Universal Units"},
                "Flour"          => {quantity: 5, units: "Centi-Units"}}
    
    assert_equal expected, pantry.convert_units(r)
  end 
  
  def test_convert_returns_converted_hash
    pantry = Pantry.new
    
    assert_equal ({quantity: 2, units: "Centi-Units"}),pantry.convert(200)
    assert_equal ({quantity: 100, units: "Milli-Units"}), pantry.convert(0.1)
    assert_equal ({quantity: 50, units: "Universal Units"}),pantry.convert(50)
  end 
  
  def test_to_centi_units_changes_hash_values_centi_units
    pantry = Pantry.new
    units = {quantity: 500, units: "Universal Units"}
    pantry.to_centi_units(units)
    
    assert_equal ({quantity: 5, units: "Centi-Units"}), units 
  end 
  
  def test_to_milli_units_changes_hash_values_to_milli_units
    pantry = Pantry.new
    units = {quantity: 0.03, units: "Universal Units"}
    pantry.to_milli_units(units)
    
    assert_equal ({quantity: 30, units: "Milli-Units"}), units 
  end 
  
  def test_add_to_shopping_list_returns_adds_ingredients_and_quantities
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)
    
    expected = {"Cheese" => 20, "Flour" => 20}
    
    assert_equal expected, pantry.shopping_list
  end 
  
  def test_add_to_shopping_list_can_adds_multiple_recipes_with_overlapping_ingredients
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r1)
    
    r2 = Recipe.new("Spaghetti")
    r2.add_ingredient("Noodles", 10)
    r2.add_ingredient("Sauce", 10)
    r2.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r2)
    
    expected = {"Cheese" => 25, "Flour" => 20, "Noodles" => 10, "Sauce" => 10}
    
    assert_equal expected, pantry.shopping_list
  end 
    
end
