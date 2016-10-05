require 'rails_helper'

RSpec.describe Sale, type: :model do
  describe 'validation' do
    it {should validate_presence_of :customer }
    it {should validate_presence_of :user }
    it {should validate_presence_of :date }
    it {should allow_value('', nil).for(:status) }
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :customer }
    it { should have_one :invoice }
    it { should have_many :items }
  end

end
