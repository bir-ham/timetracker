require 'rails_helper'

describe 'invitations' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
  end

  it "allows customers to be created" do
    within('#user_dropdown_menu') do
      select_generic(I18n.t('customers.index.header'), from: 'dropdown-menu')
    end  
    click_link I18n.t('customers.index.add_new_customer_button')

    fill_in "Name", with: "Alex"
    fill_in "Phone", with: "12345678910"
    fill_in "Email", with: "alex@example.com"
    fill_in "Phone", with: "Kifle ketam: Bole, Kebele: 21, House number: 324"
    
    submit_form

    expect(page).to have_text I18n.t('cutomers.new.notice_create')
    expect(page).to have_text "Alex"
  end

  it "displays customer validations" do
    within('#user_dropdown_menu') do
      select_generic(I18n.t('customers.index.header'), from: 'dropdown-menu')
    end  
    click_link I18n.t('customers.index.add_new_customer_button')
    expect(page).to have_text "can't be blank"
  end

  it "allows customers to be edited" do
    cutomer = create(:cutomer)

    within('#user_dropdown_menu') do
      select_generic(I18n.t('customers.index.header'), from: 'dropdown-menu')
    end  
    click_link I18n.t('button.edit')

    fill_in "Name", with: "Alex edited"
    submit_form

    expect(page).to have_text I18n.t('customers.update.notice_update')
    expect(page).to have_text "Alex edited"
  end
  
end