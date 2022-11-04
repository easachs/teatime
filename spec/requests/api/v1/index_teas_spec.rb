# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Index teas' do
  it 'returns formatted response' do
    Tea.create!(title: 'chai', description: 'sweet', temperature: 100, brew_time: 5)
    Tea.create!(title: 'green tea', description: 'relaxing', temperature: 120, brew_time: 7)
    Tea.create!(title: 'earl grey', description: 'gross', temperature: 110, brew_time: 6)
    Tea.create!(title: 'chamomille', description: 'sleepy', temperature: 130, brew_time: 8)
    get '/api/v1/teas'

    expect(response.status).to eq(200)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to be_a(Hash)
    expect(parsed_response.keys.length).to eq(1)
    expect(parsed_response).to have_key(:data)
    expect(parsed_response[:data].keys.length).to eq(2)
    expect(parsed_response[:data]).to have_key(:type)
    expect(parsed_response[:data]).to have_key(:teas)
    expect(parsed_response[:data][:teas]).to be_a(Array)
    expect(parsed_response[:data][:teas].length).to eq(4)
    teas = parsed_response[:data][:teas]
    teas.each do |tea|
      expect(tea).to have_key(:id)
      expect(tea).to have_key(:attributes)
      expect(tea[:attributes].keys.length).to eq(4)
      expect(tea[:attributes]).to have_key(:title)
      expect(tea[:attributes]).to have_key(:description)
      expect(tea[:attributes]).to have_key(:temperature)
      expect(tea[:attributes]).to have_key(:brew_time)
    end
  end
end
