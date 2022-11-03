# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cancel subscription' do
  before :each do
  end

  it 'returns formatted response' do
    eli = Customer.create!(first_name: 'eli', last_name: 'sachs', email: 'es@g', address: '2264 Dexter')
    chai = Tea.create!(title: 'chai', description: 'sweet', temperature: 100, brew_time: 5)
    subscription = Subscription.create!(title: 'bundle', price: 5.50, frequency: 'weekly', tea: chai, customer: eli)
    patch "/api/v1/subscriptions/#{subscription.id}"

    expect(response).to be_successful
    expect(response.status).to eq(202)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response[:data][:type]).to eq('subscriptions')
    expect(parsed_response[:data][:id]).to be_a(Integer)
    expect(parsed_response[:data][:attributes].keys.length).to eq(6)
    expect(parsed_response[:data][:attributes][:title]).to eq('bundle')
    expect(parsed_response[:data][:attributes][:price]).to eq(5.50)
    expect(parsed_response[:data][:attributes][:status]).to eq('cancelled')
    expect(parsed_response[:data][:attributes][:frequency]).to eq('weekly')
    expect(parsed_response[:data][:attributes][:tea_id]).to eq(chai.id)
    expect(parsed_response[:data][:attributes][:customer_id]).to eq(eli.id)
  end

  it 'errors when bad request' do
    patch '/api/v1/subscriptions/999'

    expect(response.status).to eq(404)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: 'Not found' })
  end
end
