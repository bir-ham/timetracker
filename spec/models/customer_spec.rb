require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of :phone_number }
    it { should validate_uniqueness_of :phone_number }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    
    it { should_not allow_value('loremlipsum').for(:email) }
    it { should_not allow_value('1234567').for(:phone) }
    it { should allow_value('', nil).for(:address) }

    it 'fails validation with either phone_number or email not filled' do 
      customer_with_phone_number_and_email = build(:customer, phone_number: '12345678910', email: 'alex@example.com')
      customer_with_only_phone_number_filled = build(:customer, phone_number: '12345678910', email: '')
      customer_with_both_field_empty = build(:customer, phone_number: '', email: '')
      expect(customer_with_phone_number_and_email).to be_valid
      expect(customer_with_only_phone_number_filled).to be_valid
      expect(customer_with_both_field_empty).to be_invalid
    end
  end

  describe 'associations' do
    'It belongs to invoice'    
  end  
end
