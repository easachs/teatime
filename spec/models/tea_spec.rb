require 'rails_helper'

RSpec.describe Tea do
  describe 'relations' do
    it { should have_many(:subscriptions) }
    it { should have_many(:customers).through(:subscriptions) }
  end
  
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
  end
end