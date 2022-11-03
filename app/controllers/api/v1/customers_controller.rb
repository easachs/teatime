# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      def create
        customer = Customer.create(request_params) if request_params
        if !request_params
          render json: { error: 'missing payload in request body' }, status: 400
        elsif customer.save
          render json: CustomerSerializer.new_customer_response(customer), status: :created
        else
          render json: { error: customer.errors.full_messages * ', ' }, status: 400
        end
      end
    end
  end
end
