class CustomersController < ApplicationController
  #before_action :set_invoice, only: [:show, :edit, :upate, :destroy]

  def index
    @customers = Customer.first
    respond_to do |format|
      format.html
      format.json { render json: CustomersDatatable.new(view_context) }
    end
  end

  def new
    @customer = Customer.new
    session[:new_action_called_from] = URI(request.referer).path
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      if session[:new_action_called_from] == '/projects/new'
        redirect_to new_project_path
      elsif session[:new_action_called_from] == '/sales/new'
        redirect_to new_sale_path  
      else
        redirect_to customers_path, notice: I18n.t('customers.create.notice_create')
      end
    else
      render :new
    end
  end

  # GET /invoices/1
  def show
    @customer = Customer.find(params[:id])
  end

  # GET /invoices/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(customer_params)
      flash.now[:success] = I18n.t('customers.update.success_update')
      render :show
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      redirect_to customers_url, notice: I18n.t('customers.destroy.success_delete', name: @customer.name)
    else
      flash.now[:error] = I18n.t('invoices.distroy.error_delete')
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :phone_number, :email,
      :address)
  end

end