require 'rails_helper'

describe 'tasks' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
    @project = create(:project_with_customer_and_user)
  end

  it 'allows user to create tasks' do
    visit project_path(@project)

    expect(page).to have_link I18n.t('projects.tasks.new.add_task')

    fill_in 'Name', with: 'Task'
    fill_in 'Hour', with: '3'
    within('.task_payment_type') do
      select_generic('Per hour', from: 'payment_type')
    end
    fill_in 'Price', with: '24.40'
    fill_in 'Vat (in %)', with: '10'

    submit_form

    expect(page).to have_text I18n.t('projects.tasks.create.notice_create')
    expect(page).to have_text '24.40'
    expect(page).to have_text '10'
  end

  it 'display task validations' do
    visit project_path(@project)

    expect(page).to have_link I18n.t('projects.tasks.new.add_task')

    fill_in 'Hour', with: 'abc'

    submit_form

    expect(page).to have_text 'should be only numbers and colon'
    expect(page).to have_text "can't be blank"
  end

  describe 'when task exists' do
    before(:each) do
      @task = create(:task, project: @project)
      visit projects_path
      visit project_path(@project)

      expect(page).to have_text @project.tasks[0].name
      expect(page).to have_text @project.tasks[0].hourquantity

      expect(page).to have_css '.fa-pencil-square-o'
      expect(page).to have_css '.fa-trash'
    end

    it 'allows invoice to be edited' do
      find('.fa-pencil-square-o').click

      fill_in 'Hour', with: '4'

      submit_form

      expect(page).to have_text I18n.t('projects.tasks.update.success_update')
      expect(page).to have_text @invoice.tasks[0].name
      expect(page).to have_text '4'
    end

    it 'allows invoice to be deleted' do
      find('.trash').click

      expect(page).to have_text I18n.t('tasks.destroy.success_delete')
      expect(page).to_not have_text @invoice.tasks[0].name
      expect(page).to_not have_text @invoice.tasks[0].hour
    end
  end

end