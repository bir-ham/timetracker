require 'rails_helper'

describe 'customers', js: true do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
  end

  it "allows customers to be created" do
    visit customers_path

    click_link I18n.t('customers.index.add_new_customer_button')

    fill_in "Name", with: "Alex"
    fill_in "Phone number", with: "12345678910"
    fill_in "Email", with: "alex@example.com"
    fill_in "Address", with: "Kifle ketam: Bole, Kebele: 21, House number: 324"

    submit_form
    
    expect(page).to have_text I18n.t('customers.create.notice_create')    
    expect(page).to have_text "Alex"
  end

  it "displays customer validations" do
    visit customers_path

    click_link I18n.t('customers.index.add_new_customer_button')
    submit_form
    expect(page).to have_text "can't be blank"
  end

  describe 'when customer exists' do    
    before do
      switch_schema account
      @customer = create(:customer)
      
      visit customers_path
      
      click_link I18n.t('button.view')
      expect(page).to have_text @customer.name

      expect(page).to have_link I18n.t('button.delete')
      expect(page).to have_link I18n.t('button.edit')
    end

    it "allows customers to be edited" do
      click_link I18n.t('button.edit')

      fill_in "Name", with: "Alex edited"
      submit_form

      expect(page).to have_text I18n.t('customers.update.success_update')
      expect(page).to have_text "Alex edited"
    end

    it 'allows customer to be deleted' do
      click_link I18n.t('button.delete')

      expect(page).to have_text I18n.t('customers.destroy.confirmation_msg')

      sleep 2
      
      within('.modal-footer') do
        click_link I18n.t('button.delete')
      end

      expect(page).to have_text I18n.t('customers.destroy.success_delete', name: @customer.name)
      within('.alert') do
        expect(page).to have_text @customer.name
      end  
    end
  end

end