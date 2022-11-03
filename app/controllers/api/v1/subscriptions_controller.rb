# frozen_string_literal: true

module Api
  module V1
    class SubscriptionsController < ApplicationController
      def create
        subscription = Subscription.create(request_params) if request_params
        if !request_params
          render json: { error: 'missing payload in request body' }, status: :bad_request
        elsif subscription.save
          render json: SubscriptionSerializer.subscription_response(subscription), status: :created
        else
          render json: { error: subscription.errors.full_messages * ', ' }, status: :bad_request
        end
      end

      def update
        subscription = Subscription.find(params[:id])
        subscription.update(status: 'cancelled')
        render json: SubscriptionSerializer.subscription_response(subscription), status: :accepted
      end
    end
  end
end
