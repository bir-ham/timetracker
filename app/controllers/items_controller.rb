class ItemContorller < ApplicationController

  def index
    @items = Item.all

  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(invoice_params)
    if @item.save
      redirect_to items_path, notice: I18n.t('items.create.notice_create')
    else
      render :new
    end  
  end

  # GET /invoices/1
  def show 
    @item = Item.find(params[:id]) 
  end

  # GET /invoices/1/edit
  def edit
    @item = Item.find(params[:id]) 
  end

  def update
    @item = Item.find(params[:id]) 
    if @item.update_attributes(item_params)
      flash.now[:success] = I18n.t('items.update.success_update')
      render :show
    else
      render :edit
    end 
  end

  def destroy
    @item = Item.find(params[:id]) 
    if @item.destroy
      redirect_to items_url, notice: I18n.t('items.destroy.success_delete')
    else
      flash.now[:error] = I18n.t('items.distroy.error_delete')
    end  
  end

  private
    def item_params
      params.require(:item).permit(:description, :date, :quantity, :unit, :unit_price, :vat)
    end  

end