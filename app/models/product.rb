class Product < ActiveRecord::Base

	# Defining the Relationship
	has_many 			:line_items
	before_destroy 		:ensure_not_referenced_by_any_line_item

	# Field Validation
	validates 			:title, :description, :image_url, presence: true
	validates 			:title, uniqueness: true
	validates 			:price, numericality: {greater_than_or_equal_to: 0.01}
	validates 			:image_url, allow_blank: true, format: {
						with: 		%r{\.(gif|jpg|jpeg|png)$}i,
						message: 	'must be a URL for GIF, JPG or PNG image.'
	}

	private

    # DELETE condition
		# Ensure that there are no line items referencing this product
		def ensure_not_referenced_by_any_line_item
			if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
		end

end
