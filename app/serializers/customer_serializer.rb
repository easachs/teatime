# frozen_string_literal: true

class CustomerSerializer
  def self.new_customer_response(customer)
    {
      data: {
        type: 'customers',
        id: customer.id,
        attributes: {
          first_name: customer.first_name,
          last_name: customer.last_name,
          email: customer.email,
          address: customer.address
        }
      }
    }
  end
end
