# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create customer' do
  it 'returns formatted response' do
    params = { first_name: 'eli', last_name: 'sachs', email: 'es@g', address: '2264 Dexter' }
    post '/api/v1/customers', params: params.to_json

    expect(response).to be_successful
    expect(response.status).to eq(201)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response[:data][:type]).to eq('customers')
    expect(parsed_response[:data][:id]).to be_a(Integer)
    expect(parsed_response[:data][:attributes].keys.length).to eq(4)
    expect(parsed_response[:data][:attributes][:first_name]).to eq('eli')
    expect(parsed_response[:data][:attributes][:last_name]).to eq('sachs')
    expect(parsed_response[:data][:attributes][:email]).to eq('es@g')
    expect(parsed_response[:data][:attributes][:address]).to eq('2264 Dexter')
  end

  it 'errors when address field blank' do
    params = { first_name: 'eli', last_name: 'sachs', email: 'es@g' }
    post '/api/v1/customers', params: params.to_json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: "Address can't be blank" })
  end

  it 'errors when email field blank' do
    params = { first_name: 'eli', last_name: 'sachs', address: '2264 Dexter' }
    post '/api/v1/customers', params: params.to_json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: "Email can't be blank" })
  end

  it 'errors when last_name field blank' do
    params = { first_name: 'eli', email: 'es@g', address: '2264 Dexter' }
    post '/api/v1/customers', params: params.to_json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: "Last name can't be blank" })
  end

  it 'errors when first_name field blank' do
    params = { last_name: 'sachs', email: 'es@g', address: '2264 Dexter' }
    post '/api/v1/customers', params: params.to_json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: "First name can't be blank" })
  end

  it 'errors when email already taken' do
    params = { first_name: 'eli', last_name: 'sachs', email: 'es@g', address: '2264 Dexter' }
    post '/api/v1/customers', params: params.to_json

    expect(response).to be_successful
    expect(response.status).to eq(201)

    post '/api/v1/customers', params: params.to_json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: 'Email has already been taken' })
  end

  it 'errors when no payload' do
    post '/api/v1/customers'

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to eq({ error: 'missing payload in request body' })
  end
end
