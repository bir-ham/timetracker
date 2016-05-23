class InvoicesController < ApplicationController 
  #before_action :set_invoice, only: [:show, :edit, :upate, :destroy]
  
  def index
    #@invoices = Invoice.all
    @search = InvoiceSearch.new(params[:search])
    @invoices = @search.scope
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to invoices_path, notice: I18n.t('invoices.create.notice_create')
    else
      render :new
    end  
  end

  # GET /invoices/1
  def show 
    @invoice = Invoice.find(params[:id]) 
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id]) 
  end

  def update
    @invoice = Invoice.find(params[:id]) 
    if @invoice.update_attributes(invoice_params)
      flash.now[:success] = I18n.t('invoices.update.success_update')
      render :show
    else
      render :edit
    end 
  end

  def destroy
    @invoice = Invoice.find(params[:id]) 
    if @invoice.destroy
      redirect_to invoices_url, notice: I18n.t('invoices.destroy.success_delete')
    else
      flash.now[:error] = I18n.t('invoices.distroy.error_delete')
    end  
  end

  private

  def invoice_params
    params.require(:invoice).permit(:customer, :salesperson, :date_of_an_invoice, 
      :deadline, :payment_term, :interest_on_arrears, :reference_number, :description)
  end  

end