class ProjectsController < ApplicationController

  def index
    @q = Project.ransack(params[:q])
    @projects = @q.result(distinct: true).paginate(:page => params[:page]).order("created_at DESC")
  end

  def new
    @project = Project.new
    session[:new_action_called_from] = URI(request.referer).path
  end

  def create
    @project = Project.new(project_params)
    @project.status = 'NEW'
    @project.user_id = current_user.id
    if @project.save
      if session[:new_action_called_from] == '/invoices/new'
        redirect_to new_invoice_path
      else
        redirect_to projects_path, notice: I18n.t('projects.new.notice_create')
      end
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
      flash.now[:success] = I18n.t('projects.update.success_update')
      render :show
    else
      render :edit
    end

  end
  
  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to @project, notice: I18n.t('projects.destroy.success_delete', project_name: @project.name)
    else
      flash.now[:error] = I18n.t('projects.destroy.error_delete')
    end
  end

  private
  def project_params
    params.require(:project).permit(:name, :status, :deadline, :customer_id, :archived)
  end

end