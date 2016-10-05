class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    @task = Task.new

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
    @project.status = 'NEW'
    if @project.save
      redirect_to projects_path, notice: I18n.t('projects.new.notice_create')
    else
      render :new
    end
  end

  # GET /sales/1
  def show
    @project = Project.find(params[:id])
    @task = Task.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @task = Task.new
    if @project.update(project_params)
      flash.now[:success] = I18n.t('projects.update.notice_update')
      render :show
    else
      render :edit
    end

  end

  private

  def project_params
    params.require(:project).permit(:name, :status, :deadline, :customer_id, :user_id, :archived)
  end

end