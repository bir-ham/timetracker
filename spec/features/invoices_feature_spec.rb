require 'rails_helper'

describe 'invoices', js: true do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
    switch_schema account
    @customer = create(:customer)
    @sale = create(:sale, user: user, customer: @customer)
  end

  it 'allows user to create invoices' do
    visit invoices_path
    click_link I18n.t('invoices.index.create_invoice')

    within('.invoice_sale') do
      select_generic("#{@sale.date} to #{@sale.customer.name}", from: 'invoice_sale_id')
    end

    submit_form
    
    fill_in 'invoice_reference_number', with: '1234'
    fill_in 'invoice_date_of_an_invoice', with: Date.today.tomorrow.strftime('%d/%m/%Y')
    fill_in 'invoice_deadline', with: Date.tomorrow.strftime('%d/%m/%Y')
    fill_in 'invoice_description', with: 'Lorem lipsum'

    #select_date_and_time(DateTime.now, from: 'invoice_deadline')

    submit_form
  
    expect(page).to have_text Date.tomorrow
    expect(page).to have_text '1234'

    expect(page).to have_text @sale.date
    expect(page).to have_text @sale.customer.name

    submit_form

    expect(page).to have_text I18n.t('invoices.create.notice_create')
  end

  it 'display invoice validations' do
    visit invoices_path
    click_link I18n.t('invoices.index.create_invoice')

    within('.invoice_sale') do
      select_generic("#{@sale.date} to #{@sale.customer.name}", from: 'invoice_sale_id')
    end

    submit_form

    fill_in 'invoice_reference_number', with: 'abcd'
    fill_in 'invoice_description', with: 'Lorem lipsum'

    within('.invoice_payment_term') do
      select_generic(13, from: 'invoice_payment_term')
    end

    fill_in 'invoice_date_of_an_invoice', with: Date.today.tomorrow.strftime('%d/%m/%Y')
    fill_in 'invoice_deadline', with: 7.days.ago.tomorrow.strftime('%d/%m/%Y')

    submit_form

    expect(page).to have_text 'is not a number'
    expect(page).to have_text "can't be in the past"
    expect(page).to have_text 'specify deadline or payment term. Not both filled, nor both empty'
  end

  describe 'when invoice exists' do
    before(:each) do
      switch_schema account
      @invoice = create(:invoice, user: user, sale: @sale, deadline: Date.tomorrow, status: 'PENDING', payment_term: '')
      visit invoices_path

      visit "/invoices/#{@invoice.id}"
      expect(page).to have_text @invoice.date_of_an_invoice
      expect(page).to have_text @invoice.sale.customer.name
      expect(page).to have_text @invoice.reference_number

      expect(page).to have_link I18n.t('button.delete')
      expect(page).to have_link I18n.t('button.edit')
    end

    it 'allows invoice to be edited' do
      click_link I18n.t('button.edit')

      expect(page).to have_text "#{@sale.date} to #{@sale.customer.name}"

      fill_in 'invoice_date_of_an_invoice', with: Date.today.strftime('%d/%m/%Y')
      fill_in 'invoice_reference_number', with: '1234'
      fill_in 'invoice_deadline', with: Date.tomorrow.strftime('%d/%m/%Y')
      fill_in 'invoice_description', with: 'Lorem lipsum edited'

      submit_form

      expect(page).to have_text I18n.t('invoices.update.success_update')
      expect(page).to have_text @customer.name
      expect(page).to have_text 'Lorem lipsum edited'
    end

    it 'allows invoice to be deleted' do
      click_link I18n.t('button.delete')

      expect(page).to have_text I18n.t('invoices.destroy.confirmation_msg')
      
      sleep 2
      
      within('.modal-footer') do
        click_link I18n.t('button.delete')
      end
 
      expect(page).to have_text I18n.t('invoices.destroy.success_delete')
    end
  end

end