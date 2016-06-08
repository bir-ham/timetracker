require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :date_of_an_invoice }
    it { should validate_presence_of :reference_number }
    it { should validate_uniqueness_of :reference_number }
    
    it { should allow_value('', nil).for(:interest_in_arrears) }
    it { should allow_value('', nil).for(:description) }
    it { should allow_value('1').for(:interest_in_arrears) }
    it { should_not allow_value('101').for(:interest_in_arrears) }
    it { should allow_value('lorem').for(:description) }

    it 'fails validation with both deadline and payment_term filled' do 
      invoice_with_deadline = build(:invoice, deadline: Date.current.tomorrow, payment_term: '')
      invoice_with_payment_term = build(:invoice, deadline: '', payment_term: '2')
      invoice_with_deadline_and_payment_term = build(:invoice, deadline: Date.current.tomorrow, payment_term: '2')
      invoice_with_past_deadline = build(:invoice, deadline: 7.days.ago, payment_term: '')
      expect(invoice_with_deadline).to be_valid
      expect(invoice_with_payment_term).to be_valid
      expect(invoice_with_deadline_and_payment_term).to be_invalid
      expect(invoice_with_past_deadline).to be_invalid
    end
  end

  describe 'associations' do
    it { should belong_to :customer }
    it { should belong_to :user }
  end  
end
