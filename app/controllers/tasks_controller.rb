class TasksController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @decodedVapidPublicKey = Base64.urlsafe_decode64(ENV['VAPID_PUBLIC_KEY']).bytes
    @tasks = Task.all
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      Notification.all.each do |n|
        Webpush.payload_send(
          message: "Nuevo favor al mejor postor",
          endpoint: n.endpoint,
          p256dh: n.p256dh,
          auth: n.auth,
          ttl: 24 * 60 * 60,
          vapid: {
            subject: 'mailto:sender@example.com',
            public_key: ENV['VAPID_PUBLIC_KEY'],
            private_key: ENV['VAPID_PRIVATE_KEY']
          }
        )
      end
      # redirect_to tasks_path, notice: "Mike te ayudará en breve"
    else
      # redirect_back fallback_location: root_path, alert: "Ha habido un error, llorela o intente nuevamente"
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :user)
  end
end
