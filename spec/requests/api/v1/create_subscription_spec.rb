# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create subscription' do
  before :each do
    @eli = Customer.create!(first_name: 'eli', last_name: 'sachs', email: 'es@g', address: '2264 Dexter')
    @chai = Tea.create!(title: 'chai', description: 'sweet', temperature: 100, brew_time: 5)
  end

  it 'returns formatted response' do
    params = { title: 'bundle', price: 5.50, frequency: 'weekly', tea_id: @chai.id, customer_id: @eli.id }
    post '/api/v1/subscriptions', params: params.to_json

    expect(response).to be_successful
    expect(response.status).to eq(201)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to have_key(:data)
    expect(parsed_response[:data]).to have_key(:type)
    expect(parsed_response[:data][:type]).to eq('subscriptions')
    expect(parsed_response[:data]).to have_key(:id)
    expect(parsed_response[:data][:id]).to be_a(Integer)
    expect(parsed_response[:data]).to have_key(:attributes)
    expect(parsed_response[:data][:attributes].keys.length).to eq(6)
    expect(parsed_response[:data][:attributes]).to have_key(:title)
    expect(parsed_response[:data][:attributes][:title]).to eq(Subscription.last.title)
    expect(parsed_response[:data][:attributes]).to have_key(:price)
    expect(parsed_response[:data][:attributes][:price]).to eq(Subscription.last.price)
    expect(parsed_response[:data][:attributes]).to have_key(:status)
    expect(parsed_response[:data][:attributes][:status]).to eq(Subscription.last.status)
    expect(parsed_response[:data][:attributes]).to have_key(:frequency)
    expect(parsed_response[:data][:attributes][:frequency]).to eq(Subscription.last.frequency)
    expect(parsed_response[:data][:attributes]).to have_key(:tea_id)
    expect(parsed_response[:data][:attributes][:tea_id]).to eq(Subscription.last.tea_id)
    expect(parsed_response[:data][:attributes]).to have_key(:customer_id)
    expect(parsed_response[:data][:attributes][:customer_id]).to eq(Subscription.last.customer_id)
  end

  it 'errors when customer_id field blank' do
    params = { title: 'bundle', price: 5.50, frequency: 'weekly', tea_id: @chai.id }
    post '/api/v1/subscriptions', params: params.to_json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: 'Customer must exist' })
  end

  it 'errors when tea_id field blank' do
    params = { title: 'bundle', price: 5.50, frequency: 'weekly', customer_id: @eli.id }
    post '/api/v1/subscriptions', params: params.to_json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: 'Tea must exist' })
  end

  it 'errors when frequency field blank' do
    params = { title: 'bundle', price: 5.50, tea_id: @chai.id, customer_id: @eli.id }
    post '/api/v1/subscriptions', params: params.to_json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: "Frequency can't be blank" })
  end

  it 'errors when price field blank' do
    params = { title: 'bundle', frequency: 'weekly', tea_id: @chai.id, customer_id: @eli.id }
    post '/api/v1/subscriptions', params: params.to_json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: "Price can't be blank" })
  end

  it 'errors when title field blank' do
    params = { price: 5.50, frequency: 'weekly', tea_id: @chai.id, customer_id: @eli.id }
    post '/api/v1/subscriptions', params: params.to_json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: "Title can't be blank" })
  end

  it 'errors when no payload' do
    post '/api/v1/subscriptions'

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: 'missing payload in request body' })
  end
end
