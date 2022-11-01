require 'rails_helper'

RSpec.describe Subscription do
  describe 'relations' do
    it { should belong_to(:tea) }
    it { should belong_to(:customer) }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
  end
end