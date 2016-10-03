require 'rails_helper'

RSpec.describe Sale, type: :model do
  describe 'validation' do
    it {should validate_presence_of :customer }
    it {should validate_presence_of :user }
    it {should validate_presence_of :date }
    it {should validate_presence_of :status }
    it {should allow_value('', nil).for(:customer) }
  end

  describe 'associations' do
    it {should belong_to :user }
    it {should belong_to :customer }
    it {should has_many :items }
  end

end
