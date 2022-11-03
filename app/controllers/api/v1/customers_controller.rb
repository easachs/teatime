# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      def show
        subscriptions = Subscription.where(customer_id: request_params[:id]) if request_params
        if !request_params[:customer_id]
          render json: { error: 'missing customer_id in request body' }, status: :bad_request
        else
          render json: CustomerSerializer.tea_subscriptions(subscriptions)
        end
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
