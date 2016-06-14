require 'rails_helper'

describe 'account creation' do
  let(:subdomain) { FactoryGirl.generate(:subdomain) }
  before(:each) { sign_up(subdomain) }

  it 'allows user to create account' do
    expect(page.current_url).to include(subdomain)
    expect(Account.all.count).to eq(1)
  end

  it 'allows access of subdomain' do
    visit root_url(subdomain: subdomain)
    expect(page.current_url).to include(subdomain)
  end

  it 'allows user to confirm account' do
    open_email 'birhanu@gmail.com'
    visit_in_email 'Confirm my account'

    expect(page).to have_text I18n.t('devise.confirmations.confirmed')
  end  
  
  it 'allows account followup creation' do
    subdomain2 = "#{subdomain}2"
    sign_up(subdomain2)
    expect(page.current_url).to include(subdomain2)
    expect(Account.all.count).to eq(2)
  end

  it 'does not allow account creation on subdomain' do
    user = User.first
    subdomain = Account.first.subdomain
    sign_user_in(user, subdomain: subdomain)
    expect { visit new_account_url(subdomain: subdomain) }.to raise_error ActionController::RoutingError
  end

  def sign_up(subdomain)
    visit root_url(subdomain: false)
    click_link 'Create Account'

    #binding.pry #inserts a breakpoint here
    fill_in 'First name', with: 'Birhanu'
    fill_in 'Second name', with: 'Hailemariam'
    fill_in 'Email', with: 'birhanu@gmail.com'
    within('.account_owner_password') do
      fill_in 'Password', with: 'pw'
    end
    fill_in 'Password confirmation', with: 'pw'
    fill_in 'Subdomain', with: subdomain
    click_button 'Create Account'
  end
end


