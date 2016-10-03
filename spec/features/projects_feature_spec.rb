require 'rails_helper'

describe 'projects' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
  	set_subdomain(account.subdomain)
  	sign_user_in(user)
    @customer = create(:customer)
  end

  it "allows projects to be created" do
  	visit projects_path
  	click_link I18n.t('projects.index.create_new_project')

    fill_in "Name", with: "Project foo"
  	fill_in "Date", with: Date.today
    within('.project_user') do
      select_generic(user.first_name, from: 'project_user')
    end
    within('.project_customer') do
      select_generic(@customer.name, from: 'project_customer')
    end
    fill_in "Description", with: 'Lorem lipsum'

  	submit_form

  	expect(page).to have_text I18n.t('projects.new.notice_create')
    expect(page).to have_text Date.today
    expect(page).to have_text @customer.name
  	expect(page).to have_text "Project foo"
    expect(page).to have_text "PENDING"
    expect(page).to_not have_text "Archived"
  end

  it "displays project validations" do
  	visit projects_path
    click_link I18n.t('projects.index.create_new_project')

  	submit_form
  	expect(page).to have_text "can't be blank"
  end

  it "allows projects to be edited" do
  	project = create(:project)

  	visit projects_path
    click_link I18n.t('button.view')
  	click_link I18n.t('button.edit')
    #click_edit_project_button project.name

  	fill_in "Name", with: "Project foo edited"
  	check "Archived"
  	submit_form

  	expect(page).to have_text I18n.t('projects.update.notice_update')
  	expect(page).to have_text "Project foo edited"
    expect(page).to have_text "Archived"
  end

  #def click_edit_project_button(project_name)
  #	within find("h3", text: project_name) do
  #		page.first("a").click
  #	end
  #end
end