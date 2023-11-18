class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  # Needed to instantiate the form_with
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save # Will raise ActiveModel::ForbiddenAttributesError
      redirect_to task_path(@task)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params) # Will raise ActiveModel::ForbiddenAttributesError
    redirect_to task_path(@task)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    # No need for app/views/taks/destroy.html.erb
    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end

end
