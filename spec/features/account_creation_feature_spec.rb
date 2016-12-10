require 'rails_helper'

describe 'account creation' do
  let(:subdomain) { generate(:subdomain) }
  before(:each) { sign_up(subdomain) }
  
  before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  it 'shows confirmation message' do
    expect(page).to have_text I18n.t('devise.registrations.signed_up_but_unconfirmed')
  end

  describe 'when user is created an account' do
    before :each do
      open_email 'birhanu@example.com'
      expect(current_email).to have_body_text("You can confirm your account email through the link below:")
      expect(current_email).to have_link 'Confirm my account'
    end

    it 'allows user to create account' do
      expect(page.current_url).to include(subdomain)
      expect(Account.all.count).to eq(1)
    end

    it 'allows access of subdomain' do
      visit root_url(subdomain: subdomain)
      expect(page.current_url).to include(subdomain)
    end

    it 'allows account followup creation' do
      subdomain2 = "#{subdomain}2"
      sign_up(subdomain2)
      expect(page.current_url).to include(subdomain2)
      expect(Account.all.count).to eq(2)
    end

    it 'does not allow account creation on subdomain' do
      user = create(:user)
      subdomain = Account.first.subdomain
      sign_user_in(user, subdomain: subdomain)
      #expect { visit new_account_url(subdomain: subdomain) }.to raise_error ActionController::RoutingError
      
      visit new_account_url(subdomain: subdomain) 
      expect(current_path).to eq root_path
    end
  end

  def sign_up(subdomain)
    visit root_url(subdomain: false)
    click_link I18n.t('button.sign_up')

    #binding.pry #inserts a breakpoint here
    fill_in 'First name', with: 'Birhanu'
    fill_in 'Last name', with: 'Hailemariam'
    fill_in 'Email', with: 'birhanu@example.com'
    within('.account_owner_password') do
      fill_in 'Password', with: 'pw'
    end
    fill_in 'Password confirmation', with: 'pw'
    fill_in 'Subdomain', with: subdomain
    click_button 'Create Account'

  end
end


