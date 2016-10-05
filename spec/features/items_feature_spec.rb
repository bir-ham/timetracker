require 'rails_helper'

describe 'items' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
    @sale = create(:sale, user: user)
  end

  it 'allows user to create items' do
    visit sale_path(@sale)

    expect(page).to have_css 'button[type=submit]'

    fill_in 'item[name]', with: 'Item'
    fill_in 'item[quantity]', with: '3'
    within('.item_unit') do
      select_generic('Kilo gram', from: 'item_unit')
    end
    fill_in 'item[unit_price]', with: '24.40'
    fill_in 'item[vat]', with: '10'

    submit_form_button

    expect(page).to have_text I18n.t('sales.items.create.notice_create')
    expect(page).to have_text '3'
    expect(page).to have_text '10'
  end

  it 'display item validations' do
    visit sale_path(@sale)

    expect(page).to have_css 'button[type=submit]'

    fill_in 'item[quantity]', with: 'abc'

    submit_form_button

    expect(page).to have_text 'is not a number'
    expect(page).to have_text "can't be blank"
  end

  describe 'when item exists' do
    before(:each) do
      @sale = create(:sale_with_item, user: user)
      visit sales_path
      visit sale_path(@sale)

      expect(page).to have_text @sale.items[0].name
      expect(page).to have_text @sale.items[0].quantity

      expect(page).to have_xpath "//a[@href='/sales/#{@sale.id}/items/#{@sale.items[0].id}/edit']"
      expect(page).to have_xpath "//a[@href='/sales/#{@sale.id}/items/#{@sale.items[0].id}']"
    end

    it 'allows item to be edited' do
      find(:xpath, "//a[@href='/sales/#{@sale.id}/items/#{@sale.items[0].id}/edit']").click

      fill_in 'item[quantity]', with: '4'

      submit_form_button

      expect(page).to have_text I18n.t('sales.items.update.success_update')
      expect(page).to have_text @sale.items[0].name
      expect(page).to have_text '4'
    end

    it 'allows item to be deleted' do
      find(:xpath, "//a[@href='/sales/#{@sale.id}/items/#{@sale.items[0].id}']").click

      expect(page).to have_text I18n.t('sales.items.destroy.success_delete', name: 'Item')
    end
  end

end