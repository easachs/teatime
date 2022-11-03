# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create customer' do
  it 'returns formatted response' do
    params = { first_name: 'eli', last_name: 'sachs', email: 'es@g', address: '2264 Dexter' }

    post '/api/v1/register', params: params.to_json

    expect(response).to be_successful
    expect(response.status).to eq(201)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to have_key(:data)
    expect(parsed_response[:data]).to have_key(:type)
    expect(parsed_response[:data][:type]).to eq('customers')
    expect(parsed_response[:data]).to have_key(:id)
    expect(parsed_response[:data][:id]).to be_a(Integer)
    expect(parsed_response[:data]).to have_key(:attributes)
    expect(parsed_response[:data][:attributes].keys.length).to eq(4)
    expect(parsed_response[:data][:attributes]).to have_key(:first_name)
    expect(parsed_response[:data][:attributes][:first_name]).to eq(Customer.last.first_name)
    expect(parsed_response[:data][:attributes]).to have_key(:last_name)
    expect(parsed_response[:data][:attributes][:last_name]).to eq(Customer.last.last_name)
    expect(parsed_response[:data][:attributes]).to have_key(:email)
    expect(parsed_response[:data][:attributes][:email]).to eq(Customer.last.email)
    expect(parsed_response[:data][:attributes]).to have_key(:address)
    expect(parsed_response[:data][:attributes][:address]).to eq(Customer.last.address)
  end

  it 'errors when fields blank' do
    params = { first_name: 'eli', last_name: 'sachs', email: 'es@g' }

    post '/api/v1/register', params: params.to_json
    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: "Address can't be blank" })

    params = { first_name: 'eli', last_name: 'sachs', address: '2264 Dexter' }

    post '/api/v1/register', params: params.to_json
    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: "Email can't be blank" })

    params = { first_name: 'eli', email: 'es@g', address: '2264 Dexter' }

    post '/api/v1/register', params: params.to_json
    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: "Last name can't be blank" })

    params = { last_name: 'sachs', email: 'es@g', address: '2264 Dexter' }

    post '/api/v1/register', params: params.to_json
    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: "First name can't be blank" })
  end

  it 'errors when email already taken' do
    params = { first_name: 'eli', last_name: 'sachs', email: 'es@g', address: '2264 Dexter' }

    post '/api/v1/register', params: params.to_json
    expect(response).to be_successful
    expect(response.status).to eq(201)

    post '/api/v1/register', params: params.to_json
    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: 'Email has already been taken' })
  end

  it 'errors when no JSON payload' do
    post '/api/v1/register'
    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: 'missing JSON payload in request body' })
  end
end
