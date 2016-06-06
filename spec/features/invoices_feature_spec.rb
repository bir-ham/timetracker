require 'rails_helper'

describe 'invoices' do
  let!(:account) { create(:account_with_schema) }
  let(:confirmed_user) { account.owner }

  before do    
    set_subdomain(account.subdomain)
    sign_user_in(confirmed_user)
  end

  it 'allows user to create invoices' do
    visit invoices_path
    click_link I18n.t('invoices.index.add_new_invoice_button')

    fill_in 'Customer', with: 'ABB'
    fill_in 'Reference number', with: '1234'
    fill_in 'Description', with: 'Lorem lipsum'
    
    within('.invoice_date_of_an_invoice') do 
      select_date(Date.tomorrow, from: 'invoice_date_of_an_invoice')
    end
    #select_date_and_time(DateTime.now, from: 'invoice_deadline')
    within('.invoice_deadline') do
      select_date(Date.tomorrow, from: 'invoice_deadline')
    end
      
    submit_form
    
    expect(page).to have_text I18n.t('invoices.create.notice_create')
    expect(page).to have_text 'ABB'
  end

  it 'display invoice validations' do
    visit invoices_path
    click_link I18n.t('invoices.index.add_new_invoice_button')

    fill_in 'Customer', with: 'ABB'
    fill_in 'Reference number', with: 'abcd'
    fill_in 'Description', with: 'Lorem lipsum'
    
    within('.invoice_status_type') do 
      select_generic(PAID, from: 'invoice_status_type')
    end 

    within('.invoice_payment_term') do 
      select_generic(13, from: 'invoice_payment_term')
    end 

    within('.invoice_date_of_an_invoice') do 
      select_date(Date.tomorrow, from: 'invoice_date_of_an_invoice')
    end

    within('.invoice_deadline') do
      select_date(7.days.ago, from: 'invoice_deadline')
    end
      
    submit_form
    
    expect(page).to have_text 'is not a number'
    expect(page).to have_text "can't be in the past"
    expect(page).to have_text 'specify a deadline or a payment term. Not both empty, nor both filled'
  end 
  
  describe 'when invoice exists' do
    before(:each) do
      @invoice = create(:invoice, deadline: Date.tomorrow, payment_term: '') 
      visit invoices_path
   
      click_link I18n.t('button.show')
      expect(page).to have_text @invoice.date_of_an_invoice 
      expect(page).to have_text @invoice.customer
      expect(page).to have_text @invoice.reference_number
    
      expect(page).to have_link I18n.t('button.delete')
      expect(page).to have_link I18n.t('button.edit')
    end   

    it 'allows invoice to be edited' do
      click_link I18n.t('button.edit')
      
      fill_in 'Customer', with: 'ABB edited'
      fill_in 'Reference number', with: '1234'
      fill_in 'Description', with: 'Lorem lipsum edited'

      within('.invoice_deadline') do
        select_date(Date.tomorrow, from: 'invoice_deadline')
      end

      submit_form
      expect(page).to have_text I18n.t('invoices.update.success_update')
      expect(page).to have_text 'ABB edited'
      expect(page).to have_text 'Lorem lipsum edited'
    end  

    it 'allows invoice to be deleted' do
      click_link I18n.t('button.delete')
      
      expect(page).to have_text I18n.t('invoices.destroy.confirmation_msg')     
     
      wait_until_modal_dialog_javascript_loads do
        within('.modal-footer') do 
          click_link I18n.t('button.delete')
        end
      end  
        
      expect(page).to have_text I18n.t('invoices.destroy.success_delete')
      expect(page).to_not have_text @invoice.date_of_an_invoice
      expect(page).to_not have_text @invoice.customer     
    end  
  end  

end