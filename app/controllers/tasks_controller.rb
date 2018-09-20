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
    @tasks = Task.all.order(id: :desc)
    @task = Task.new(task_params)
    @icons = Task::ICONS
    if @task.save
      TaskMailer.some_new(@task).deliver_now
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
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:description, :user)
  end
end
