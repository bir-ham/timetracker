require 'rails_helper'

RSpec.describe Sale, type: :model do
  describe 'validation' do
    it {should validate_presence_of :customer }
    it {should validate_presence_of :user }
    it {should validate_presence_of :date }
  end

  it 'should validate user and status on save' do
    expect(build(:sale, date: Date.today, user: create(:user), customer: crate(:create), status: 'PENDING')).to be_valid
    expect(build(:sale, date: Date.today, user: create(:user), customer: crate(:create), status: nil)).to be_invalid
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :customer }
    it { should have_one :invoice }
    it { should have_many :items }
  end

end
