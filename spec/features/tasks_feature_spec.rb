require 'rails_helper'

describe 'tasks' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
    @project = create(:project, user: user)
  end

  it 'allows user to create tasks' do
    visit project_path(@project)

    expect(page).to have_css 'button[type=submit]'

    fill_in 'task[name]', with: 'Task'
    fill_in 'task[hours]', with: '3'
    within('.task_payment_type') do
      select_generic('Per hour', from: 'task_payment_type')
    end
    fill_in 'task[price]', with: '24.40'
    fill_in 'task[vat]', with: '10'

    submit_form_button

    expect(page).to have_text I18n.t('projects.tasks.create.notice_create')
    expect(page).to have_text '3'
    expect(page).to have_text '10'
  end

  it 'display task validations' do
    visit project_path(@project)

    expect(page).to have_css 'button[type=submit]'

    fill_in 'task[hours]', with: 'abc'

    submit_form_button

    expect(page).to have_text 'should be only numbers and colon'
    expect(page).to have_text "can't be blank"
  end

  describe 'when task exists' do
    before(:each) do
      @project = create(:project_with_task, user: user)
      visit projects_path
      visit project_path(@project)

      expect(page).to have_text @project.tasks[0].name
      expect(page).to have_text @project.tasks[0].hours

      expect(page).to have_xpath "//a[@href='/projects/#{@project.id}/tasks/#{@project.tasks[0].id}/edit']"
      expect(page).to have_xpath "//a[@href='/projects/#{@project.id}/tasks/#{@project.tasks[0].id}']"
    end

    it 'allows task to be edited' do
      find(:xpath, "//a[@href='/projects/#{@project.id}/tasks/#{@project.tasks[0].id}/edit']").click

      fill_in 'task[hours]', with: '4'

      submit_form_button

      expect(page).to have_text I18n.t('projects.tasks.update.success_update')
      expect(page).to have_text @project.tasks[0].name
      expect(page).to have_text '4'
    end

    it 'allows task to be deleted' do
      find(:xpath, "//a[@href='/projects/#{@project.id}/tasks/#{@project.tasks[0].id}']").click

      expect(page).to have_text I18n.t('projects.tasks.destroy.success_delete', name: 'Task')
    end
  end

end