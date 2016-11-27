class ContactsController < ApplicationController

  skip_before_filter :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.request = request
  
    if @contact.invalid?
      session[:contact] = params[:contact]
      redirect_to root_path, :flash => { :error => @contact.errors.full_messages.join(', ') }
    else
      if @contact.deliver
        redirect_to root_path, notice: 'Thank you for your message. We will contact you soon!'  
        session[:contact] = params[:contact] = ''
      else
        flash[:alert] = 'Cannot send message. Try again.'
        redirect_to root_path   
      end  
    end  
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end