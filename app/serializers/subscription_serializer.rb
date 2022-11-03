# frozen_string_literal: true

class SubscriptionSerializer
  def self.subscription_response(subscription)
    {
      data: {
        type: 'subscription',
        id: subscription.id,
        attributes: {
          title: subscription.title,
          price: subscription.price,
          status: subscription.status,
          frequency: subscription.frequency,
          tea_id: subscription.tea.id,
          customer_id: subscription.customer.id
        }
      }
    }
  end

  def self.tea_subscriptions(customer_id)
    subscriptions = Subscription.where(customer_id: customer_id)
    {
      data: {
        type: 'subscriptions',
        subscriptions: subscriptions.map do |subscription|
          { id: subscription.id,
            attributes: {
              title: subscription.title,
              price: subscription.price,
              status: subscription.status,
              frequency: subscription.frequency,
              tea_id: subscription.tea.id,
              customer_id: subscription.customer.id
            } }
        end
      }
    }
  end
end
