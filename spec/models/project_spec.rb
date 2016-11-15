require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations" do
    it { should validate_presence_of :customer }
    it { should validate_presence_of :name }

    it { should allow_value('', nil).for(:deadline) }
    it { should allow_value('', nil).for(:description) }
  end

  it 'should validate user and status on save' do
    expect(build(:project, name: 'Project 1', deadline: Date.today, user: create(:user), 
        customer: create(:customer), status: 'NEW')).to be_valid
    expect(build(:project, name: 'Project 2', deadline: Date.today, user: create(:user), 
        customer: create(:customer), status: nil)).to be_invalid
  end

  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :customer }
    it { should have_one :invoice }
    it { should have_many :tasks }
  end

  it "defaults archived to false" do
    expect(Project.new).to_not be_archived
  end

end
