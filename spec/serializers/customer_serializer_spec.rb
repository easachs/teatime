# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomerSerializer do
  it 'formats a customer' do
    eli = Customer.create!(first_name: 'eli', last_name: 'sachs', email: 'es@g', address: '2264 Dexter')
    serializer = CustomerSerializer.new_customer_response(eli)
    expect(serializer).to be_a(Hash)
    expect(serializer.keys.length).to eq(1)
    expect(serializer).to have_key(:data)
    expect(serializer[:data].keys.length).to eq(3)
    expect(serializer[:data]).to have_key(:type)
    expect(serializer[:data]).to have_key(:id)
    expect(serializer[:data]).to have_key(:attributes)
    expect(serializer[:data][:attributes].keys.length).to eq(4)
    expect(serializer[:data][:attributes]).to have_key(:first_name)
    expect(serializer[:data][:attributes]).to have_key(:last_name)
    expect(serializer[:data][:attributes]).to have_key(:email)
    expect(serializer[:data][:attributes]).to have_key(:address)
  end
end
