class TasksController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    respond_to do |format|
      format.html do
        @task = Task.new
        @tasks = Task.all.order(id: :desc)
        @icons = Task::ICONS
      end
      format.json { render json: Task.all.order(id: :desc) }
    end
  end

  def create
    @task = Task.new(task_params)
    @icons = Task::ICONS
    if @task.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Mike te ayudará en breve" }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'index' }
        format.js
      end
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update(status: !@task.status)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
  end

  private

  def task_params
    params.require(:task).permit(:description, :user)
  end
end
