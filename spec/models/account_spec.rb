require 'rails_helper'

RSpec.describe Account, :type => :model do
  describe 'validations' do
    it { should validate_presence_of :owner }
    it { should validate_presence_of :subdomain }
    it { should validate_uniqueness_of(:subdomain).ignoring_case_sensitivity }
    it { should allow_value('birhanu').for(:subdomain) }
    it { should allow_value('test').for(:subdomain) }

    it { should allow_value('', nil).for(:industry) }
    it { should allow_value('', nil).for(:phone_number) }
    it { should_not allow_value('loremlipsum').for(:phone_number) }
    it { should allow_value('', nil).for(:email) }
    it { should_not allow_value('loremlipsum').for(:email) }
    it { should allow_value('', nil).for(:address1) }
    it { should allow_value('', nil).for(:address2) }
    it { should allow_value('', nil).for(:zip) }
    it { should_not allow_value('loremlipsum').for(:zip) }
    it { should allow_value('', nil).for(:town) }
    it { should allow_value('', nil).for(:country) } 

    it { should_not allow_value('www').for(:subdomain) }
    it { should_not allow_value('WWW').for(:subdomain) }
    it { should_not allow_value('.test').for(:subdomain) }
    it { should_not allow_value('test/').for(:subdomain) }
        
    it 'should validate case insensitive uniqueness' do
      create(:account, subdomain: 'Test')
      expect(build(:account, subdomain: 'test')).to_not be_valid
    end

    # it { should validate_presence_of :email }
    # it { should validate_uniqueness_of :email }

    # it { should allow_value('user@foo.com').for(:email) }

    # it { should_not allow_value('user@foo,com', 'user_at_foo.org', 'example.user@foo.',
    #  'foo@bar_baz.com', 'foo@bar+baz.com').for(:email) }
    # it 'should validate case insensitive uniqueness' do
    #   create(:account, email: 'User@foo.com')
    #   expect(build(:account, email: 'user@foo.com')).to_not_be_valid
    # end         
  end 

  describe 'associations' do
    it { should belong_to :owner}
  end
        
end
