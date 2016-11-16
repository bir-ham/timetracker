require 'rails_helper'

describe 'conversations' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
    @customer = create(:customer)
  end

  it 'allows user to create first project' do
    visit root_path

    expect(page).to have_text I18n.t('dashboards.index.all_income')
    expect(page).to have_link I18n.t('dashboards.index.first_project')

    click_link I18n.t('dashboards.index.first_project')
    expect(page).to have_text I18n.t('projects.new.header')

    fill_in "Name", with: "Project foo"
    fill_in "Deadline", with: Date.today

    within('.project_customer') do
      select_generic(@customer.name, from: 'project[customer_id]')
    end
    fill_in "Description", with: 'Lorem lipsum'

    submit_form

    expect(page).to have_text I18n.t('projects.new.notice_create')
    expect(page).to have_text Date.today

    visit root_path
    within (".projects") do
      expect(page).to have_text '1'
    end

  end
end  