require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations" do
    it { should validate_presence_of :customer }
    it { should validate_presence_of :user}
    it { should validate_presence_of :name }

    it { should allow_value('', nil).for(:status) }
    it { should allow_value('', nil).for(:deadline) }
    it { should allow_value('', nil).for(:description) }
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
