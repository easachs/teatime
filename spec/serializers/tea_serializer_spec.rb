# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeaSerializer do
  it 'formats all teas' do
    Tea.create!(title: 'chai', description: 'sweet', temperature: 100, brew_time: 5)
    Tea.create!(title: 'green tea', description: 'relaxing', temperature: 120, brew_time: 7)
    Tea.create!(title: 'earl grey', description: 'gross', temperature: 110, brew_time: 6)
    Tea.create!(title: 'chamomille', description: 'sleepy', temperature: 130, brew_time: 8)
    serializer = TeaSerializer.all_teas

    expect(serializer).to be_a(Hash)
    expect(serializer.keys.length).to eq(1)
    expect(serializer).to have_key(:data)
    expect(serializer[:data].keys.length).to eq(2)
    expect(serializer[:data]).to have_key(:type)
    expect(serializer[:data]).to have_key(:teas)
    expect(serializer[:data][:teas]).to be_a(Array)
    expect(serializer[:data][:teas].length).to eq(4)
    teas = serializer[:data][:teas]
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
