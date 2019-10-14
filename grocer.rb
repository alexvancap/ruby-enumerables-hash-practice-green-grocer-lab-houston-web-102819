def consolidate_cart(cart)
  result = {}

  cart.each do |item|
    item_name = item.keys[0]

    result[item_name] = item.values[0]

    if result[item_name][:count]
      result[item_name][:count] += 1
    else
      result[item_name][:count] = 1
    end
  end

  result
end

def apply_coupons(cart, coupons)

  coupons.each do |coupon|
  coupon_name = coupon[:item]
  coupon_item_num = coupon[:num]
  cart_item = cart[coupon_name]

  next if cart_item.nil? || cart_item[:count] < coupon_item_num

  cart_item[:count] -= coupon_item_num

  coupon_in_cart = cart["#{coupon_name} W/COUPON"]

  if coupon_in_cart
    coupon_in_cart[:count] += 1
  else
    cart["#{coupon_name} W/COUPON"] = {
      price: (coupon[:cost] / 2),
      clearance: cart_item[:clearance],
      count: 2
    }
  end
end

cart
end



coupons = [
  {:item => "AVOCADO", :num => 2, :cost => 5.00},
  {:item => "BEER", :num => 2, :cost => 20.00},
  {:item => "CHEESE", :num => 3, :cost => 15.00}
]

cart = {
  "AVOCADO" => {:price => 3.00, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.00, :clearance => false, :count => 1}
}


def apply_clearance(cart)
  cart.each{|item|
    if item[1][:clearance]
      p (300 / 20) * 100
    end
  }
  return cart
end

apply_clearance(cart)

def checkout(cart, coupons)
  # code here
end
