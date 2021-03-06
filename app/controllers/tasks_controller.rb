class TasksController < ApplicationController
  before_action :require_signin!
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authorize_create!, only: [:new, :create]
  before_action :authorize_update!, only: [:edit, :update]
  before_action :authorize_delete!, only: :destroy
  
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

    def authorize_create!
      if !current_user.admin? && cannot?("create tasks".to_sym, @project)
        flash[:alert] = "You cannot create tasks on this project."
        redirect_to @project
      end
    end

    def authorize_update!
      if !current_user.admin? && cannot?("edit tasks".to_sym, @project)
        flash[:alert] = "You cannot edit tasks on this project."
        redirect_to @project
      end
    end

    def authorize_delete!
      if !current_user.admin? && cannot?(:"delete tasks", @project)
        flash[:alert] = "You cannot delete tasks from this project."
        redirect_to @project
      end
    end

end
