class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    @items = Item.new

    respond_to do |format|
      format.html
      format.csv { render text: @invoices.to_csv }
      format.xls #{ render text: @invoices.to_csv(col_sep: "\t") }
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path, notice: I18n.t('projects.new.notice_create')
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @Project = Project.find(params[:id])

    if @Project.update(project_params)
      redirect_to projects_path, notice: I18n.t('projects.update.notice_update')
    else
      render :edit
    end

  end

  private

  def project_params
    params.require(:project).permit(:name, :customer_id, :user_id, :status, :archived)
  end

end