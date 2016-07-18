class ContactsController < ApplicatoinController

def new
  @contact = Contact.new
end

def create
  @contact = Contact.new(params[:contact])
  @contact.request = request
  if @contact.deliver
    flash.now[:notice] I18n.t('landing_page.contacts.create.notice')
  else
    flash.now[:error] I18n.t('landing_page.contacts.create.error')
    render :new
  end
end

end