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

    fill_in "Name", with: "Project 1"
  	fill_in "Deadline", with: Date.today
    within('.project_customer') do
      select_generic(@customer.name, from: 'project[customer_id]')
    end
    fill_in "Description", with: 'Lorem lipsum'

  	submit_form

  	expect(page).to have_text I18n.t('projects.new.notice_create')
    expect(page).to have_text Date.today
    expect(page).to have_text @customer.name
  	expect(page).to have_text "Project 1"
    expect(page).to have_text "NEW"
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
    click_project_header_link project.name
  	click_link I18n.t('button.edit')

  	fill_in "Name", with: "Project 1 edited"
    check 'Archived'

  	submit_form

  	expect(page).to have_text I18n.t('projects.update.success_update')
    expect(page).to have_text I18n.t('projects.show.archived')
  end

  def click_project_header_link(project_name)
  	within find("h4", text: project_name) do
  		page.first("a").click
  	end
  end
end