require 'rails_helper'

describe 'items' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
    @sale = create(:sale_with_customer_and_user)
  end

  it 'allows user to create items' do
    visit sale_path(@sale)

    expect(page).to have_link I18n.t('invoices.items.new.add_item')

    fill_in 'Name', with: 'Lorem lipsum'
    fill_in 'Quantity', with: '3'
    within('.item_unit') do
      select_generic('kg', from: 'item_unit')
    end
    fill_in 'Unit price', with: '24.40'
    fill_in 'Vat (in %)', with: '10'

    submit_form

    expect(page).to have_text I18n.t('invoices.items.create.notice_create')
    expect(page).to have_text '24.40'
    expect(page).to have_text '10'
  end

  it 'display item validations' do
    visit sale_path(@sale)

    expect(page).to have_link I18n.t('invoices.items.new.add_item')

    fill_in 'Quantity', with: 'abc'

    submit_form

    expect(page).to have_text 'is not a number'
    expect(page).to have_text "can't be blank"
  end

  describe 'when item exists' do
    before(:each) do
      @item = create(:item, sale: @sale)
      visit sales_path
      visit sale_path(@sale)

      expect(page).to have_text @sale.items[0].name
      expect(page).to have_text @sale.items[0].quantity

      expect(page).to have_css '.fa-pencil-square-o'
      expect(page).to have_css '.fa-trash'
    end

    it 'allows invoice to be edited' do
      find('.fa-pencil-square-o').click

      fill_in 'Quantity', with: '4'

      submit_form

      expect(page).to have_text I18n.t('invoices.items.update.success_update')
      expect(page).to have_text @invoice.items[0].name
      expect(page).to have_text '4'
    end

    it 'allows invoice to be deleted' do
       find('.trash').click

      expect(page).to have_text I18n.t('items.destroy.success_delete')
      expect(page).to_not have_text @invoice.items[0].name
      expect(page).to_not have_text @invoice.items[0].quantity
    end
  end

end