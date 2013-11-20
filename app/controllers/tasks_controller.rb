class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_signin!, except: [:show, :index]
  
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
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = @project.tasks.find(params[:id])
    end

    def require_signin!
      if current_user.nil?
        flash[:error] = "You need to sign in or sign up before continuing."
        redirect_to signin_url
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    helper_method :require_signin!
    helper_method :current_user
end
