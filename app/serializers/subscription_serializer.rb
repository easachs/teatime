# frozen_string_literal: true

class SubscriptionSerializer
  def self.subscription_response(subscription)
    {
      data: {
        type: 'subscriptions',
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
end
