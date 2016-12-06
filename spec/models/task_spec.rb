require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :hours }
    it { should validate_presence_of :payment_type }
    it { should validate_presence_of :price }

    it { should allow_value('', nil).for(:vat) }
  end

  describe 'associations' do
    it { should belong_to :project }
    it { should have_one :invoice }
  end
end
