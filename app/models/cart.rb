class Cart < ActiveRecord::Base

  # Defining the relationships between the cart and line items
  # Note that line_items require the existence of a cart, if the cart is destroyed
  # the line item will also be destroyed
  
	has_many :line_items, dependent: :destroy
end
