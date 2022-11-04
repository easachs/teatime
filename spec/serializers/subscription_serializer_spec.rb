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

  it "formats a customer's subscriptions" do
    eli = Customer.create!(first_name: 'eli', last_name: 'sachs', email: 'es@g', address: '2264 Dexter')
    chai = Tea.create!(title: 'chai', description: 'sweet', temperature: 100, brew_time: 5)
    green = Tea.create!(title: 'green tea', description: 'relaxing', temperature: 120, brew_time: 7)
    earl = Tea.create!(title: 'earl grey', description: 'gross', temperature: 110, brew_time: 6)
    Subscription.create!(title: 'bundle', price: 5.50, frequency: 'weekly', tea: chai, customer: eli)
    Subscription.create!(title: 'bundle', price: 4.50, frequency: 'weekly', tea: green, customer: eli)
    Subscription.create!(title: 'bundle', price: 9.50, status: 'cancelled', frequency: 'weekly', tea: chai,
                         customer: eli)
    Subscription.create!(title: 'bundle', price: 9.50, status: 'cancelled', frequency: 'weekly', tea: earl,
                         customer: eli)
    serializer = SubscriptionSerializer.tea_subscriptions(eli.id)

    expect(serializer).to be_a(Hash)
    expect(serializer.keys.length).to eq(1)
    expect(serializer).to have_key(:data)
    expect(serializer[:data].keys.length).to eq(2)
    expect(serializer[:data]).to have_key(:type)
    expect(serializer[:data]).to have_key(:subscriptions)
    expect(serializer[:data][:subscriptions]).to be_a(Array)
    expect(serializer[:data][:subscriptions].length).to eq(4)
    subscriptions = serializer[:data][:subscriptions]
    subscriptions.each do |subscription|
      expect(subscription).to have_key(:id)
      expect(subscription).to have_key(:attributes)
      expect(subscription[:attributes].keys.length).to eq(6)
      expect(subscription[:attributes]).to have_key(:title)
      expect(subscription[:attributes]).to have_key(:price)
      expect(subscription[:attributes]).to have_key(:status)
      expect(subscription[:attributes]).to have_key(:frequency)
      expect(subscription[:attributes]).to have_key(:tea_id)
      expect(subscription[:attributes]).to have_key(:customer_id)
    end
  end
end
