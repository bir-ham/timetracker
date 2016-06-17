require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'validations' do 
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:second_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end 

  describe 'associations' do
  end
end
