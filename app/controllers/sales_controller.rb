class SalesController < ApplicationController

  def index
    @q = Sale.ransack(params[:q])
    @sales = @q.result(distinct: true).paginate(:page => params[:page]).order("created_at DESC")
  end

  def new
    @sale = Sale.new
    session[:new_action_called_from] = URI(request.referer).path
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.status = 'PREPARING'
    @sale.user_id = current_user.id
    if @sale.save
      if session[:new_action_called_from] == '/invoices/new'
        redirect_to new_invoice_path
      else
        redirect_to @sale, notice: I18n.t('sales.create.notice_create')
      end
    else
      render :new
    end
  end

  # GET /sales/1
  def show
    @sale = Sale.find(params[:id])
    @item = Item.new
  end

  # GET /sales/1/edit
  def edit
    @sale = Sale.find(params[:id])
  end

  def update
    @sale = Sale.find(params[:id])
    @item = Item.new
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
      redirect_to @sale, notice: I18n.t('sales.destroy.success_delete', sale_date: @sale.date)
    else
      flash.now[:error] = I18n.t('sales.destroy.error_delete')
    end
  end

  private
  def sale_params
    params.require(:sale).permit(:date, :customer_id, :status, :description)
  end

end