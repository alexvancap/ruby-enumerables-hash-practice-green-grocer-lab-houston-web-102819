def consolidate_cart(cart)
  cart.each_with_object({}) do |item, result|
    item.each do |type, attributes|
      if result[type]
        attributes[:count] += 1
      else
        attributes[:count] = 1
        result[type] = attributes
      end
    end
  end
end

cart = [{"AVOCADO" => {:price => 3.00, :clearance => true}},
{"KALE" => {:price => 3.00, :clearance => false}},
{"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
{"ALMONDS" => {:price => 9.00, :clearance => false}},
{"TEMPEH" => {:price => 3.00, :clearance => true}},
{"CHEESE" => {:price => 6.50, :clearance => false}},
{"BEER" => {:price => 13.00, :clearance => false}},
{"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
{"BEETS" => {:price => 2.50, :clearance => false}},
{"SOY MILK" => {:price => 4.50, :clearance => true}}]

coupons = [
  {:item => "AVOCADO", :num => 2, :cost => 5.00},
  {:item => "BEER", :num => 2, :cost => 20.00},
  {:item => "CHEESE", :num => 3, :cost => 15.00}
]

def apply_coupons(cart, coupons)
  result = {}
  # code here#
  cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] =  info[:count] - coupon[:num]
        if result["#{food} W/COUPON"]
          result["#{food} W/COUPON"][:count] += 1
        else
          result["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
        end
      end
    end
    result[food] = info
  end
  p result
end



def apply_clearance(cart)
  cart.each do |name, properties|
    if properties[:clearance]
      updated_price = properties[:price] * 0.80
      properties[:price] = updated_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0
  final_cart.each do |name, properties|
    total += properties[:price] * properties[:count]
  end
  total = total * 0.9 if total > 100
  total
end
