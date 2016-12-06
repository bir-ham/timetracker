class AccountsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:new, :create, :subdomain, :subdomain_check]

  def new
    @account = Account.new
    @account.build_owner
  end

  def create
    @account = Account.new(account_params)
    if @account.valid?
      Apartment::Tenant.create(@account.subdomain)
      Apartment::Tenant.switch!(@account.subdomain)
      @account.save
      redirect_to new_user_session_url(subdomain: @account.subdomain),  notice: I18n.t('devise.registrations.signed_up_but_unconfirmed')
    else
      render action: 'new'
    end
  end

  def show
    @account = current_account 
  end

   def edit
    @account = current_account 
  end

  def update
    @account = current_account 
    if @account.update_attributes(account_params)
      flash.now[:success] = I18n.t('accounts.update.success_update')
      render :show
    else
      render :edit
    end
  end

  def subdomain_check
    unless params[:subdomain].value?("")
      @account = Account.find_by(subdomain: params[:subdomain].values.first.downcase)
      if @account
        Apartment::Tenant.switch!(@account.subdomain)
        
        redirect_to new_user_session_url(subdomain: @account.subdomain)
      else 
        flash.now[:alert] = I18n.t('devise.sessions.subdomain_not_found') 
        render :subdomain
      end  
    else
      @error = I18n.t('accounts.subdomain.error')
      render action: 'subdomain'
    end  
  end
  
  def subdomain
    
  end

  private
    def account_params
      params.require(:account).permit(:subdomain, :industry, :phone_number, :email, :address1, :address2, :zip, :town, :country, :logo,
        owner_attributes: [:first_name, :last_name, :email, :password, :password_confirmation])
    end

end
