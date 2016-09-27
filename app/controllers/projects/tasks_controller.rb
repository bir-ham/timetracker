class Projects::TasksController < ApplicationController

  def index
    @tasks = task.all

  end

  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = Task.new(task_params)
    total_price = params[:task][:quantity].to_i * params[:task][:unit_price].to_d
    @task.total = total_price
    @task.project = @project

    if @task.save
      redirect_to projects_path, notice: I18n.t('projects.tasks.create.notice_create')
    else
      render :new
    end
  end

  # GET /projects/1
  def show
    @task = task.find(params[:id])
  end

  # GET /projects/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash.now[:success] = I18n.t('projects.tasks.update.success_update')
      render :show
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
    name = @task.name
    if @task.destroy
      redirect_to projects_path, notice: I18n.t('projects.tasks.destroy.success_delete', name: name)
    else
      flash.now[:error] = I18n.t('projects.tasks.distroy.error_delete')
    end
  end

  private
    def task_params
      params.require(:task).permit(:name, :date, :quantity, :unit, :unit_price, :vat)
    end

end