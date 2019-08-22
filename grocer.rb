def consolidate_cart(cart)
  new = {}
  cart.each do |elem|
    if new[elem.keys[0]]
      new[elem.keys[0]][:count] += 1 
    else
      new[elem.keys[0]] = {
        count:  1,
        price:  elem.values[0][:price],
        clearance: elem.values[0][:clearance]
      }
    end
  end
  new
end

def apply_coupons(cart, coupons)

  
  coupons.each do |coupon|
    coupon.each do |w|
      num = coupon[:num]
      item = coupon[:item]
      if cart[item] && cart[item][:count] >= num
        if cart["#{item} W/COUPON"]
          cart["#{item} W/COUPON"][:count] += num
        else
          cart["#{item} W/COUPON"] = {
          :price => (coupon[:cost] / num),
          :clearance => cart[item][:clearance],
          :count => num
        }
        end
      cart[item][:count] -= num
      end
    end
  end
  cart
end

def apply_clearance(cart)
  keys = cart.keys
  keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price] * 0.8).round(2)
    else
    end
  end
  cart
end

def checkout(cart, coupons)
  total_cart = consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  
  
end
