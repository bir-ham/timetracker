require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :customer }

    context 'if invoice step' do 
      before { subject { lambda { |i| i.current_step == 'invoice' } } }

      it { should validate_presence_of :user }
      it { should validate_presence_of :date_of_an_invoice }
      it { should validate_presence_of :reference_number }
      it { should validate_uniqueness_of :reference_number }
      
      it { should allow_value('', nil).for(:interest_in_arrears) }
      it { should allow_value('', nil).for(:description) }
      it { should allow_value('1').for(:interest_in_arrears) }
      it { should_not allow_value('101').for(:interest_in_arrears) }
      it { should allow_value('lorem').for(:description) }

      it 'should validate deadline or payment term' do 
        expect(build(:invoice, deadline: Date.current.tomorrow, payment_term: '')).to be_valid
        expect(build(:invoice, deadline: '', payment_term: '2')).to be_valid
        expect(build(:invoice, deadline: Date.current.tomorrow, payment_term: '2')).to be_invalid
      end
    end  
  end

  describe 'associations' do
    it { should belong_to :customer }
    it { should belong_to :user }
  end  
end
