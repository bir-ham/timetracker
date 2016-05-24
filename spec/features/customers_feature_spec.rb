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

  describe 'when invoice exists' do
    before(:each) do
      @cutomer = create(:cutomer) 
      visit invoices_path
   
      click_link I18n.t('button.show')
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

    it 'allows cutomer to be deleted' do
      click_link I18n.t('button.delete')
      wait_until_javascript_loads do
        expect(page).to have_text I18n.t('invoices.destroy.confirmation_msg')     
     
        page.has_css?('.modal-footer')
        binding.pry
        within('.modal-footer') do 
          click_link I18n.t('button.delete')
        end

        expect(page).to have_text I18n.t('customers.destroy.success_delete')
        expect(page).to_not have_text @cutomer.name
        expect(page).to_not have_text @customer.phone_number
      end       
    end  
  end 

end