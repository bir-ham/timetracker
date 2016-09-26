class Projects::ItemsController < ApplicationController

  def index
    @items = Item.all

  end

  def new
    @project = Project.find(params[:project_id])
    @item = Item.new
  end

  def create
    @project = Project.find(params[:project_id])
    @item = Item.new(item_params)
    total_price = params[:item][:quantity].to_i * params[:item][:unit_price].to_d
    @item.total = total_price
    @item.project = @project

    if @item.save
      redirect_to @project, notice: I18n.t('projects.items.create.notice_create')
    else
      render :new
    end
  end

  # GET /projects/1
  def show
    @item = Item.find(params[:id])
  end

  # GET /projects/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash.now[:success] = I18n.t('projects.items.update.success_update')
      render :show
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @item = Item.find(params[:id])
    name = @item.name
    if @item.destroy
      redirect_to @project, notice: I18n.t('projects.items.destroy.success_delete', name: name)
    else
      flash.now[:error] = I18n.t('projects.items.distroy.error_delete')
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :date, :quantity, :unit, :unit_price, :vat)
    end

end