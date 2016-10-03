require 'rails_helper'

describe 'sales' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
     @customer = create(:customer)
  end

  it "allows sale to be created" do
    visit sales_path
    click_link I18n.t('sales.index.add_new_sale')

    fill_in "Date", with: Date.today
    within('.sale_user') do
      select_generic(user.first_name, from: 'sale_user')
    end
    within('.sale_customer') do
      select_generic(@customer.name, from: 'sale_customer')
    end
    fill_in "Description", with: 'Lorem lipsum'
    submit_form

    expect(page).to have_text I18n.t('sales.new.notice_create')
    expect(page).to have_text Date.today
    expect(page).to have_text @customer.name
  end

  it "displays sale validations" do
    visit sales_path
    click_link I18n.t('sales.index.add_new_sale')

    within('.sale_user') do
      select_generic(user.first_name, from: 'sale_user')
    end

    submit_form
    expect(page).to have_text "can't be blank"
  end

  it "allows projects to be edited" do
    sale = create(:sale)

    visit sales_path
    click_link I18n.t('button.view')
    click_link I18n.t('button.edit')

    fill_in "Date", with: Date.today
    within('.sale_user') do
      select_generic(user.first_name, from: 'sale_user')
    end
    fill_in "Description", with: 'Lorem lipsum edited'
    submit_form

    expect(page).to have_text I18n.t('projects.update.notice_update')
    expect(page).to have_text user.first_name
    expect(page).to have_text "Lorem lipsum edited"
  end

end