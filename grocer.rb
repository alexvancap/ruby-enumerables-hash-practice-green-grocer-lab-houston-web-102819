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
       item[1][:price] -= (item[1][:price] * 0.2)
    end
  }
  return cart
end


def checkout(cart, coupons)
  cart = consolidate_cart(cart: cart)
  cart = apply_coupons(cart:cart, coupons: coupons)
  cart = apply_clearance(cart: cart)

  total = 0
  cart.each { |k,v| total += v[:price] * v[:count] }
  total > 100 ? (total * 0.9).round(2) : total
end

p checkout(cart, coupons)
