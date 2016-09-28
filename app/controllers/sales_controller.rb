class SalesController < ApplicationController
def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
    session[:new_action_called_from] = URI(request.referer).path
  end

  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      if session[:new_action_called_from] == '/projects/new'
        redirect_to new_project_path
      else
        redirect_to sales_path, notice: I18n.t('sales.create.notice_create')
      end
    else
      render :new
    end
  end

  # GET /invoices/1
  def show
    @sale = Sale.find(params[:id])
  end

  # GET /invoices/1/edit
  def edit
    @sale = Sale.find(params[:id])
  end

  def update
    @sale = Sale.find(params[:id])
    if @sale.update_attributes(sale_params)
      flash.now[:success] = I18n.t('sales.update.success_update')
      render :show
    else
      render :edit
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    if @sale.destroy
      redirect_to sales_url, notice: I18n.t('sales.destroy.success_delete')
    else
      flash.now[:error] = I18n.t('invoices.distroy.error_delete')
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:date, :status, :description)
  end

end