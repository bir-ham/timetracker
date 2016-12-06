require 'rails_helper'

describe 'conversations' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
  end

  it 'allows user to send email' do
    click_link I18n.t('navigation.see_all_messages')

    expect(page).to have_text I18n.t('conversations.index.inbox')
    expect(page).to have_link I18n.t('conversations.index.new_message')

    click_link I18n.t('conversations.index.new_message')
    expect(page).to have_text I18n.t('messages.new.header')

    within('.recipients') do
      select_generic(user.first_name)
    end
    fill_in 'message[subject]', with: 'Test title'
    fill_in 'message[body]', with: 'Lorem lipsum'

    submit_form_button

    expect(page).to have_text I18n.t('messages.create.success')

    within('.messages-badge') do
      expect(page).to have_text '1'
    end
  end

  it 'allows user to read sent email' do
    click_link I18n.t('navigation.see_all_messages')

    # Send email manually to test Sent 
    click_link I18n.t('conversations.index.new_message')
    within('.recipients') do
      select_generic(user.first_name)
    end
    fill_in 'message[subject]', with: 'Test title'
    fill_in 'message[body]', with: 'Lorem lipsum'

    submit_form_button
    click_link I18n.t('navigation.see_all_messages')

    expect(page).to have_text I18n.t('conversations.index.sent')

    find(:xpath, "//a[@href='/conversations?box=sent']").click
    expect(page).to have_link 'Test title'

    click_link 'Test title'

    expect(page).to have_text 'Lorem lipsum'
  end
end