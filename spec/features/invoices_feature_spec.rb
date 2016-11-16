require 'rails_helper'

describe 'invoices' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before(:all) do
    Capybara.current_driver = :webkit
  end

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
    @customer = create(:customer)
    @sale = create(:sale, user: user, customer: @customer)
  end

  it 'allows user to create invoices' do
    visit invoices_path
    click_link I18n.t('invoices.index.create_invoice')

    within('.invoice_sale') do
      select_generic("#{@sale.date} to #{@sale.customer.name}", from: 'invoice[sale_id]')
    end

    submit_form

    fill_in 'Reference number', with: '1234'
    fill_in 'Description', with: 'Lorem lipsum'
    fill_in 'invoice_date_of_an_invoice', with: Date.today
    fill_in 'invoice_deadline', with: Date.tomorrow

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
      select_generic("#{@sale.date} to #{@sale.customer.name}", from: 'invoice[sale_id]')
    end

    submit_form

    fill_in 'Reference number', with: 'abcd'
    fill_in 'Description', with: 'Lorem lipsum'

    within('.invoice_payment_term') do
      select_generic(13, from: 'invoice_payment_term')
    end

    fill_in 'invoice_date_of_an_invoice', with: Date.today
    fill_in 'invoice_deadline', with: 7.days.ago

    submit_form

    expect(page).to have_text 'is not a number'
    expect(page).to have_text "can't be in the past"
    expect(page).to have_text 'specify deadline or payment term. Not both filled, nor both empty'
  end

  describe 'when invoice exists' do
    before(:each) do
      @invoice = create(:invoice, user: user, sale: @sale, deadline: Date.tomorrow, payment_term: '')
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

      within('.invoice_sale') do
        select_generic("#{@sale.date} to #{@sale.customer.name}", from: 'invoice[sale_id]')
      end

      fill_in 'invoice_date_of_an_invoice', with: Date.today
      fill_in 'Reference number', with: '1234'
      fill_in 'Description', with: 'Lorem lipsum edited'
      fill_in 'invoice_deadline', with: Date.tomorrow

      submit_form
      expect(page).to have_text I18n.t('invoices.update.success_update')
      expect(page).to have_text @customer.name
      expect(page).to have_text 'Lorem lipsum edited'
    end

    it 'allows invoice to be deleted', js: true do
      click_link I18n.t('button.delete')

      wait_for_ajax

      expect(page).to have_text I18n.t('invoices.destroy.confirmation_msg')

      within('.modal-footer') do
        click_link I18n.t('button.delete')
      end

      expect(page).to have_text I18n.t('invoices.destroy.success_delete')
      expect(page).to_not have_text @invoice.date_of_an_invoice
      expect(page).to_not have_text @invoice.customer
    end
  end

  after(:all) do
    Capybara.use_default_driver
  end

end