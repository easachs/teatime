# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      def show
        render json: SubscriptionSerializer.tea_subscriptions(params[:id])
      end

      def create
        customer = Customer.create(request_params) if request_params
        if !request_params
          render json: { error: 'missing payload in request body' }, status: :bad_request
        elsif customer.save
          render json: CustomerSerializer.new_customer_response(customer), status: :created
        else
          render json: { error: customer.errors.full_messages * ', ' }, status: :bad_request
        end
      end
    end
  end
end
