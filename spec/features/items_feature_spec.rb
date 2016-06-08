require 'rails_helper'

describe 'invoices' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do    
    set_subdomain(account.subdomain)
    sign_user_in(user)
  end

  it 'allows user to create items' do
    visit items_path
    click_link I18n.t('items.index.add_new_item_button')

     
    submit_form
    
    expect(page).to have_text I18n.t('items.create.notice_create')
  end

  it 'display item validations' do
    visit items_path
    click_link I18n.t('items.index.add_new_item_button')

    submit_form
    
    expect(page).to have_text 'is not a number'
    expect(page).to have_text "can't be blank"
  end 
  
  describe 'when item exists' do
    before(:each) do
      @item = create(:item) 
      visit invoices_path
   
      click_link I18n.t('button.show')
      expect(page).to have_text @item.description
      expect(page).to have_text @item.date  
      expect(page).to have_text @item.quantity
    
      expect(page).to have_link I18n.t('button.delete')
      expect(page).to have_link I18n.t('button.edit')
    end   

    it 'allows invoice to be edited' do
      click_link I18n.t('button.edit')
      
      submit_form
      expect(page).to have_text I18n.t('items.update.success_update')
      expect(page).to have_text @item.description
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
      expect(page).to_not have_text @item.description
      expect(page).to_not have_text @item.quantity     
    end  
  end  

end