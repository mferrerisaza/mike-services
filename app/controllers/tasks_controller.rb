class TasksController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Mike te ayudará en breve"
    else
      redirect_back fallback_location: root_path, alert: "Ha habido un error, llorela o intente nuevamente"
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :user)
  end
end
