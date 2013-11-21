class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_signin!
  
  def new
    @task = @project.tasks.build
  end

  def create
    @task = @project.tasks.build(task_params)
    @task.user = current_user

    if @task.save
      flash[:notice] = 'Task has been created.'
      redirect_to [@project, @task]
    else
      flash[:alert] = 'Task has not been created.'
      render 'new'
    end
  end

  def show
    # see :set_task
  end

  def edit
    # see :set_task
  end

  def update
    if @task.update(task_params)
      flash[:notice] = 'Task has been updated.'
      redirect_to [@project, @task]
    else
      flash[:alert] = 'Task has not been updated.'
      render action: 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = 'Task has been deleted.'
    redirect_to @project
  end

  private
    def task_params
      params.require(:task).permit(:title, :description)
    end

    def set_project
      @project = Project.for(current_user).find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking for could not be found."
      redirect_to root_path
    end

    def set_task
      @task = @project.tasks.find(params[:id])
    end
end
