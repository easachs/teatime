# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show customer subscriptions' do
  it 'returns formatted response' do
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
    get "/api/v1/customers/#{eli.id}"

    expect(response.status).to eq(200)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to be_a(Hash)
    expect(parsed_response.keys.length).to eq(1)
    expect(parsed_response).to have_key(:data)
    expect(parsed_response[:data].keys.length).to eq(2)
    expect(parsed_response[:data]).to have_key(:type)
    expect(parsed_response[:data]).to have_key(:subscriptions)
    expect(parsed_response[:data][:subscriptions]).to be_a(Array)
    subscriptions = parsed_response[:data][:subscriptions]
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

  it 'errors when bad request' do
    get '/api/v1/customers/999'

    expect(response.status).to eq(200)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ data: { type: 'subscriptions', subscriptions: [] } })
  end
end
