require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :phone_number }
    it { should validate_uniqueness_of :phone_number }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :address }
    
    it { should_not allow_value('loremlipsum').for(:email) }
    it { should_not allow_value('1234567').for(:phone) }
    it { should allow_value('', nil).for(:address) }
  end

  describe 'associations' do
    'It belongs to invoice'    
  end  
end
