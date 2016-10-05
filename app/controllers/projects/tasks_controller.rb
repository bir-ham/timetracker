class Projects::TasksController < ApplicationController
  include CalculationHelper

  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = Task.new(task_params)

    total_price = 0
    if (params[:task][:payment_type] == 'Per hour')
      tokens = params[:task][:hours].split(':')
      hours = tokens[0]
      minutes = tokens[1]
      converted_minutes = convert_minutes_to_hour(minutes)
      duration = hours.to_i + converted_minutes
      total_price = duration * params[:task][:price].to_d
    else
      total_price = params[:task][:price].to_d
    end
    @task.total = total_price
    @task.project = @project

    if @task.save
      redirect_to @project, notice: I18n.t('projects.tasks.create.notice_create')
    else
      render 'projects/show'
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
    render 'projects/show'
  end

  def update
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      redirect_to @project, notice: I18n.t('projects.tasks.update.success_update')
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
    name = @task.name
    if @task.destroy
      redirect_to @project, notice: I18n.t('projects.tasks.destroy.success_delete', name: name)
    else
      flash.now[:error] = I18n.t('projects.tasks.destroy.error_delete')
    end
  end

  private
    def task_params
      params.require(:task).permit(:name, :hours, :payment_type, :price, :vat)
    end

end