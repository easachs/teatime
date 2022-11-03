# frozen_string_literal: true

module Api
  module V1
    class SubscriptionsController < ApplicationController
      def index
        if request_params
          teas = Tea.joins(:subscriptions).where("subscriptions.customer_id = ?, #{request_params[:id]}")
        end
        if !request_params[:customer_id]
          render json: { error: 'missing customer_id in request body' }, status: 400
        else
          render json: CustomerSerializer.tea_subscriptions(teas)
        end
      end

      def create
        subscription = Subscription.create(request_params) if request_params
        if !request_params
          render json: { error: 'missing payload in request body' }, status: 400
        elsif subscription.save
          render json: SubscriptionSerializer.subscription_response(subscription), status: :created
        else
          render json: { error: subscription.errors.full_messages * ', ' }, status: 400
        end
      end

      def update
        subscription = Subscription.find(request_params[:subscription_id]) if request_params[:subscription_id]
        if !request_params[:subscription_id]
          render json: { error: 'missing subscription_id in request body' }, status: 400
        elsif subscription
          subscription.update(status: 'cancelled')
          render json: SubscriptionSerializer.subscription_response(subscription), status: :accepted
        else
          render json: { error: subscription.errors.full_messages * ', ' }, status: 400
        end
      end
    end
  end
end
