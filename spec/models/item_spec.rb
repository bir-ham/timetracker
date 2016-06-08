require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :description }
    it { should validate_presence_of :date }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :unit }
    it { should allow_value('', nil).for(:vat) }
  end

  describe 'associations' do
    it { should belong_to :invoice }
  end

end
