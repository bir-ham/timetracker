require 'rails_helper'

describe 'items' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }
  let(:customer) { create(:customer) }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
  end

  it 'allows user to create items' do
    @invoice = create(:invoice, user: user, customer: customer)
    visit invoice_path(@invoice)

    click_link I18n.t('invoices.items.new.add_item_button')

    fill_in 'Name', with: 'Lorem lipsum'
    within('.item_date') do
      select_date(Date.tomorrow, from: 'item_date')
    end
    fill_in 'Quantity', with: '3'
    within('.item_unit') do
      select_generic('kg', from: 'item_unit')
    end
    fill_in 'Unit price', with: '24.40'
    fill_in 'Vat (in %)', with: '10'

    submit_form

    expect(page).to have_text I18n.t('invoices.items.create.notice_create')
  end

  it 'display item validations' do
    @invoice = create(:invoice, user: user, customer: customer)
    visit invoice_path(@invoice)

    click_link I18n.t('invoices.items.new.add_item_button')
    
    within('.item_date') do
      select_date(Date.yesterday, from: 'item_date')
    end
    fill_in 'Quantity', with: 'abc'
    submit_form

    expect(page).to have_text 'is not a number'
    expect(page).to have_text "can't be in the past"
    expect(page).to have_text "can't be blank"
  end

  describe 'when item exists' do
    before(:each) do
      @invoice = create(:invoice_with_item)
      visit invoices_path
      visit invoice_path(@invoice)

      expect(page).to have_text @invoice.items[0].name
      expect(page).to have_text @invoice.items[0].date
      expect(page).to have_text @invoice.items[0].quantity

      expect(page).to have_link I18n.t('button.delete')
      expect(page).to have_link I18n.t('button.edit')      
    end

    xit 'allows invoice to be edited' do
      click_link I18n.t('button.edit')

      within('.item_date') do
        select_date(Date.tomorrow, from: 'item_date')
      end
      fill_in 'Quantity', with: '4'

      submit_form
      expect(page).to have_text I18n.t('invoices.items.update.success_update')
      expect(page).to have_text @invoice.items[0].name
      expect(page).to have_text '4'
    end

    it 'allows invoice to be deleted', js: true do
      click_link I18n.t('button.delete')

      wait_for_ajax

      expect(page).to have_text I18n.t('items.destroy.confirmation_msg')

      within('.modal-footer') do
        click_link I18n.t('button.delete')
      end
      
      expect(page).to have_text I18n.t('items.destroy.success_delete')
      expect(page).to_not have_text @invoice.items[0].name
      expect(page).to_not have_text @invoice.items[0].quantity
    end
  end

end