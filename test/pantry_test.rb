require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  def test_it_exists_and_initializes_with_empty_stock
    pantry = Pantry.new
    
    assert_instance_of Pantry, pantry
    assert_equal ({}), pantry.stock
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
end
