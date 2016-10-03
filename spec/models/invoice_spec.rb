require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do

    subject { (described_class.new) }

    context 'if invoice step' do
      before { subject.current_step = 'user_sale_project' }

      it { should validate_presence_of :user }

      it 'should validate sale or project' do
        expect(build(:invoice, sale: Sale.new, project: Project.new)).to be_invalid
        expect(build(:invoice, sale: Sale.new, project: nil)).to be_valid
      end
    end

    context 'if invoice step' do
      before { subject.current_step = 'invoice' }

      it { should validate_presence_of :date_of_an_invoice }
      it { should validate_presence_of :reference_number }
      it { should validate_uniqueness_of :reference_number }

      it { should allow_value('', nil).for(:interest_in_arrears) }
      it { should allow_value('', nil).for(:description) }
      it { should allow_value('1').for(:interest_in_arrears) }
      it { should_not allow_value('101').for(:interest_in_arrears) }
      it { should allow_value('lorem').for(:description) }

      it 'should validate deadline or payment term' do
        expect(build(:invoice, sale: Sale.new, project: nil, deadline: Date.current.tomorrow, payment_term: nil)).to be_valid
        expect(build(:invoice, sale: Sale.new, project: nil, deadline: '', payment_term: 2)).to be_valid
        expect(build(:invoice, sale: Sale.new, project: nil, deadline: Date.current.tomorrow, payment_term: 2)).to be_invalid
      end
    end
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :sale }
    it { should belong_to :project }
  end
end
