# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubscriptionSerializer do
  it 'formats a subscription' do
    eli = Customer.create!(first_name: 'eli', last_name: 'sachs', email: 'es@g', address: '2264 Dexter')
    chai = Tea.create!(title: 'chai', description: 'sweet', temperature: 100, brew_time: 5)
    subscription = Subscription.create!(title: 'bundle', price: 5.50, frequency: 'weekly', tea: chai, customer: eli)
    serializer = SubscriptionSerializer.subscription_response(subscription)
    expect(serializer).to be_a(Hash)
    expect(serializer.keys.length).to eq(1)
    expect(serializer).to have_key(:data)
    expect(serializer[:data].keys.length).to eq(3)
    expect(serializer[:data]).to have_key(:type)
    expect(serializer[:data]).to have_key(:id)
    expect(serializer[:data]).to have_key(:attributes)
    expect(serializer[:data][:attributes].keys.length).to eq(6)
    expect(serializer[:data][:attributes]).to have_key(:title)
    expect(serializer[:data][:attributes]).to have_key(:price)
    expect(serializer[:data][:attributes]).to have_key(:status)
    expect(serializer[:data][:attributes]).to have_key(:frequency)
    expect(serializer[:data][:attributes]).to have_key(:tea_id)
    expect(serializer[:data][:attributes]).to have_key(:customer_id)
  end
end
