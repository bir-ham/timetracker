require 'rails_helper'

describe 'items' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
  end

  it 'allows user to create items' do
    visit items_path
    click_link I18n.t('items.index.add_new_item_button')

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

    expect(page).to have_text I18n.t('items.create.notice_create')
  end

  it 'display item validations' do
    visit items_path
    click_link I18n.t('items.index.add_new_item_button')
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
      @item = create(:item)
      visit items_path

      click_link I18n.t('button.show')
      expect(page).to have_text @item.name
      expect(page).to have_text @item.date
      expect(page).to have_text @item.quantity

      expect(page).to have_link I18n.t('button.delete')
      expect(page).to have_link I18n.t('button.edit')
    end

    it 'allows invoice to be edited' do
      click_link I18n.t('button.edit')

      within('.item_date') do
        select_date(Date.tomorrow, from: 'item_date')
      end
      fill_in 'Quantity', with: '4'

      submit_form
      expect(page).to have_text I18n.t('items.update.success_update')
      expect(page).to have_text @item.name
      expect(page).to have_text '4'
    end

    it 'allows invoice to be deleted' do
      click_link I18n.t('button.delete')

      expect(page).to have_text I18n.t('items.destroy.confirmation_msg')

      wait_until_modal_dialog_javascript_loads do
        within('.modal-footer') do
          click_link I18n.t('button.delete')
        end
      end

      expect(page).to have_text I18n.t('items.destroy.success_delete')
      expect(page).to_not have_text @item.name
      expect(page).to_not have_text @item.quantity
    end
  end

end