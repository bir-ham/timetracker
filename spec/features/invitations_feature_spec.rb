require 'rails_helper'

describe 'invitations' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
  	set_subdomain(account.subdomain)
  	sign_user_in(user)

    visit users_path     
  end

  it 'validates email' do
    fill_in 'Email', with: 'wrong'
    click_button I18n.t('users.index.invite_user')
    expect(page).to have_content I18n.t('devise.invitations.create.header')
    expect(page).to have_content 'invalid'
  end

  it 'shows the owner in the authorized users list' do
   	expect(page).to have_content user.first_name
    expect(page).to have_content user.last_name
  	expect(page).to have_content user.email
  	expect(page).to have_selector '.glyphicon-ok'
  end

  describe 'when user is invited' do
    before do
      fill_in 'Email', with: 'birhanu@example.com'
      click_button I18n.t('users.index.invite_user')
    end

    it 'shows invitation when user is invited' do
    	expect(page).to have_content 'invitation email has been sent'
    	expect(page).to have_content 'birhanu@example.com'
    	expect(page).to have_content 'Invitation Pending'
    end

    context 'user accepts invitation' do
      before do
        click_link 'Sign out'
        open_email 'birhanu@example.com'
        visit_in_email 'Accept invitation'

        fill_in 'First name', with: 'Birhanu test'
        fill_in 'Last name', with: 'Hailemariam'
        fill_in 'Password', with: 'pw'
        fill_in 'Password confirmation', with: 'pw'
        click_button I18n.t('devise.invitations.edit.create_account_button')
      end

      it 'confirms account creation' do
        expect(page).to have_content 'Your account was created successfully'
      end

      it 'shows a check mark on the user page' do
        visit users_path
        within('tr', text: 'Birhanu test') do
          expect(page).to have_selector '.glyphicon-ok'
        end
      end
    end
  end
end